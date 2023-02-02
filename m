Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EAD368837F
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 16:56:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233163AbjBBP4R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 10:56:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232960AbjBBPzY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 10:55:24 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F8B866FBF
        for <linux-kernel@vger.kernel.org>; Thu,  2 Feb 2023 07:54:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675353274;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=negYAZ7XN8B3B48WSqZhThnhQsqI7SKK1pB//896v0c=;
        b=NZpciChuaVnkazsbdUH3ZBGX/c2DnjXYKGxn0kRrL5p0N3ikHmK/ZarZa07scnh4DF8Vf3
        AM/C6mZV1FmHC10joVnkf1EKPJBsuz3QwdNnaSv6DmQfjIDajkSc8oN5huETy1Zf6gLfMY
        p/W6ykR1egF+EhLZs4q6AAutwTNPoM8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-253-dNzHb1_zP2uhv0jZpOqVgw-1; Thu, 02 Feb 2023 10:54:31 -0500
X-MC-Unique: dNzHb1_zP2uhv0jZpOqVgw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id AF0F3101A52E;
        Thu,  2 Feb 2023 15:54:30 +0000 (UTC)
Received: from tpad.localdomain (ovpn-112-2.gru2.redhat.com [10.97.112.2])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 1B0F42026D4B;
        Thu,  2 Feb 2023 15:54:30 +0000 (UTC)
Received: by tpad.localdomain (Postfix, from userid 1000)
        id 125B1403BF03F; Thu,  2 Feb 2023 12:54:12 -0300 (-03)
Date:   Thu, 2 Feb 2023 12:54:12 -0300
From:   Marcelo Tosatti <mtosatti@redhat.com>
To:     Christoph Lameter <cl@gentwo.de>
Cc:     Aaron Tomlin <atomlin@atomlin.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 3/5] mm/vmstat: use cmpxchg loop in cpu_vm_stats_fold
Message-ID: <Y9vcpO5Dh2G3Y6ib@tpad>
References: <20230201195013.881721887@redhat.com>
 <20230201195104.460373427@redhat.com>
 <fb371ac-cf69-28a6-eca0-6caccda4e0b8@gentwo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fb371ac-cf69-28a6-eca0-6caccda4e0b8@gentwo.de>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 02, 2023 at 03:38:58PM +0100, Christoph Lameter wrote:
> On Wed, 1 Feb 2023, Marcelo Tosatti wrote:
> 
> > In preparation to switch vmstat shepherd to flush
> > per-CPU counters remotely, use a cmpxchg loop
> > instead of a pair of read/write instructions.
> 
> You are mixing full atomic cmpxchg and  per cpu atomic cmpxchg? That does
> not work.

OK, missing locked on the local functions. Can fix that.

> I thought you would only run this while the kernel is not active on the
> remote cpu? Then you dont need any cmpxchg and you can leave the function
> as is.

The remote cpu can enter kernel mode while this function executes.

There is no mode which indicates userspace cannot enter the kernel.


