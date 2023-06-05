Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A03FA722F73
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 21:15:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232167AbjFETPe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 15:15:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229792AbjFETP3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 15:15:29 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A97FF120
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jun 2023 12:14:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1685992480;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=SfydRo3YLfaDwYR7ylzaAXxWorOycnW9DfmBoaznkn8=;
        b=eeZz3mf8qH3j7Ur4VTjhB2/7bbzSeHro7DnLe16EhrCZtq2rnnmVa3Naj+M9Z3JdhphMyg
        KGqHkmeryoxTPjwPS5X/KzRPIGHHZ8enOdRcPQiT+IAuO8FsLxpaCARlri/7v/b4d8JHZG
        Ske6oMUx83SFnJlru38iynW2Sg12bv4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-553-bc_Knc7RNfO_8NWo23UGlQ-1; Mon, 05 Jun 2023 15:14:37 -0400
X-MC-Unique: bc_Knc7RNfO_8NWo23UGlQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 305AF8032EF;
        Mon,  5 Jun 2023 19:14:37 +0000 (UTC)
Received: from tpad.localdomain (ovpn-112-3.gru2.redhat.com [10.97.112.3])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id F12F140CFD46;
        Mon,  5 Jun 2023 19:14:36 +0000 (UTC)
Received: by tpad.localdomain (Postfix, from userid 1000)
        id 556E0400DC4D5; Mon,  5 Jun 2023 16:14:18 -0300 (-03)
Date:   Mon, 5 Jun 2023 16:14:18 -0300
From:   Marcelo Tosatti <mtosatti@redhat.com>
To:     Michal Hocko <mhocko@suse.com>
Cc:     Christoph Lameter <cl@linux.com>,
        Aaron Tomlin <atomlin@atomlin.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH v2 2/3] vmstat: skip periodic vmstat update for nohz full
 CPUs
Message-ID: <ZH40CnznHeBVb/Rb@tpad>
References: <20230602185757.110910188@redhat.com>
 <20230602190115.521067386@redhat.com>
 <ZH2VDaF9uODTqAfV@dhcp22.suse.cz>
 <ZH33BI9//tAbLvz5@tpad>
 <ZH4FhQ5Lh6xFBjyz@dhcp22.suse.cz>
 <ZH4c/MqHoWiA0PaQ@tpad>
 <ZH4wC0gEbsz+H/Aa@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZH4wC0gEbsz+H/Aa@dhcp22.suse.cz>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URI_DOTEDU autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 05, 2023 at 08:57:15PM +0200, Michal Hocko wrote:
> > Guest initiated I/O, since the host CPU is isolated.
> 
> Make it explicit in the changelog.

I think better use of our time would be to focus on

https://lkml.iu.edu/hypermail/linux/kernel/2209.1/01263.html

1) Operate in terms of add CPU, remove CPU on sysfs (to avoid races).
2) Don't allow all CPUs to be marked as "block_interf".
3) Remove percpu rwsem lock.

> I am just wondering how you can achieve your strict deadlines when IO is
> involved but that is another story I guess.

IO can be submitted when the ELF binary and libraries are read
from the virtual disk, for example. 

