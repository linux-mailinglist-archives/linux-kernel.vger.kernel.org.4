Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10AE268B7A2
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 09:45:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229722AbjBFIo3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 03:44:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjBFIoR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 03:44:17 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38CB130F4
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 00:43:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675673010;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xFAsq3rcCmFOrfjXB3RbRsPrgyIlYafL+F+rS2YB1wU=;
        b=NDeaIHXz5WxTBOjeJmGQ55HOgPEFAjb3/aosOk0Xq2uUTfYj+7GImMJ1KrHJ9Um4FW+fwT
        xLhTqXsXpgvlnINKj1/+mGIr9ZkdkXz+DHNGylmRnVxt2hiSUifkg2MwLTO5VD1YbjWV5i
        lzzpiqmqpD5OI/5mAS3mvf9mXJN/Iq4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-66-e3ObXPXeMj-ioAFB_NIF7g-1; Mon, 06 Feb 2023 03:43:26 -0500
X-MC-Unique: e3ObXPXeMj-ioAFB_NIF7g-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9888F18A63EC;
        Mon,  6 Feb 2023 08:43:25 +0000 (UTC)
Received: from localhost (ovpn-12-71.pek2.redhat.com [10.72.12.71])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id C2E3B40398A0;
        Mon,  6 Feb 2023 08:43:24 +0000 (UTC)
Date:   Mon, 6 Feb 2023 16:43:21 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Stephen Brennan <stephen.s.brennan@oracle.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org, urezki@gmail.com,
        lstoakes@gmail.com, willy@infradead.org, hch@infradead.org,
        error27@gmail.com
Subject: Re: [PATCH v4 0/7] mm/vmalloc.c: allow vread() to read out
 vm_map_ram areas
Message-ID: <Y+C9qbbrYRtxHva9@MiWiFi-R3L-srv>
References: <20230201091339.61761-1-bhe@redhat.com>
 <87357o7yeh.fsf@oracle.com>
 <Y93bGLwIROQB3Yfs@MiWiFi-R3L-srv>
 <20230204151322.7b3d10ea11c3f4ca0a93db23@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230204151322.7b3d10ea11c3f4ca0a93db23@linux-foundation.org>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/04/23 at 03:13pm, Andrew Morton wrote:
> On Sat, 4 Feb 2023 12:12:08 +0800 Baoquan He <bhe@redhat.com> wrote:
> 
> > > So this definitely still resolves the originally reported issue. Feel
> > > free to add, if you want:
> > > 
> > > Tested-by: Stephen Brennan <stephen.s.brennan@oracle.com>
> > 
> > I noticed Andrew had picked this v4 into his mm tree, maybe Andrew can
> > help add this Tested-by tag.
> 
> I dropped this series and am now unable to locate a fix which addressed
> the issue which Stephen hit.

Stephen wanted to read out vm_map_ram areas, that can't be done w/o this
patchset. The patch 3 solves his problem.

> 
> Please send a v5?

I add Stephen's Reported-by and Tested-by in patch 3 and send v5.

