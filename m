Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FF25646813
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 05:04:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229752AbiLHEEd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 23:04:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbiLHEEa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 23:04:30 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C13632CC90
        for <linux-kernel@vger.kernel.org>; Wed,  7 Dec 2022 20:03:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1670472212;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jHrhx6+79Jl3ft6O4UZcMqaubIrHp9gGZE3MaJ/Gw6g=;
        b=iQVhnxG8oCKjkFlDnJwZPsDcDDnjDHzYZsgmc4WwPYYmWOYULZD08W+Tmzq2qa1HCHP20l
        BQzzUsUrtMJ8EBakotS8+KKSqtqrN82YmbI51k6TARN41AfR5m90XAOBf0nlpBk9Bdsc77
        BN4JMkoZvGtVDPeEZ0VRWxOOGXL9DOM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-19-ccbyXt8iMgWzL3wDrvVn1Q-1; Wed, 07 Dec 2022 23:03:25 -0500
X-MC-Unique: ccbyXt8iMgWzL3wDrvVn1Q-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B381181D9F2;
        Thu,  8 Dec 2022 04:03:24 +0000 (UTC)
Received: from localhost (ovpn-13-206.pek2.redhat.com [10.72.13.206])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 5D62A2027061;
        Thu,  8 Dec 2022 04:03:23 +0000 (UTC)
Date:   Thu, 8 Dec 2022 12:03:19 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Eric DeVolder <eric.devolder@oracle.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        kexec@lists.infradead.org, ebiederm@xmission.com,
        dyoung@redhat.com, vgoyal@redhat.com, tglx@linutronix.de,
        mingo@redhat.com, dave.hansen@linux.intel.com, hpa@zytor.com,
        nramas@linux.microsoft.com, thomas.lendacky@amd.com,
        robh@kernel.org, efault@gmx.de, rppt@kernel.org, david@redhat.com,
        sourabhjain@linux.ibm.com, konrad.wilk@oracle.com,
        boris.ostrovsky@oracle.com
Subject: Re: [PATCH v14 3/7] crash: add generic infrastructure for crash
 hotplug support
Message-ID: <Y5FiBwepe/M8+yuU@MiWiFi-R3L-srv>
References: <20221116214643.6384-1-eric.devolder@oracle.com>
 <20221116214643.6384-4-eric.devolder@oracle.com>
 <Y4A1/cSekXUTFriC@MiWiFi-R3L-srv>
 <Y5BkL8x01KWoF502@zn.tnic>
 <Y5CIvcZLuokwyGYT@MiWiFi-R3L-srv>
 <Y5CKNqtDm5VT+gsz@zn.tnic>
 <Y5Cb3KGDXijyBXfM@MiWiFi-R3L-srv>
 <Y5C3mzQLviL54IK6@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y5C3mzQLviL54IK6@zn.tnic>
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

On 12/07/22 at 04:56pm, Borislav Petkov wrote:
> On Wed, Dec 07, 2022 at 09:57:48PM +0800, Baoquan He wrote:
> > I thought we usually need to introduce the kernel config option, then
> > add code related to it, so that is a wrong idea.
> 
> It depends: sometimes it is prudent to add the code behind an ifdeffery
> first but have it not being buildable so that you don't have to deal
> with build breakages but rather concentrate on adding the facilities
> first.
> 
> And you add the Kconfig item only in the end where everything is in
> place and it should build properly then.

I see. Now it's pretty clear to us. Thanks a lot.

> 
> > It would be helpful to tell this somewhere in document.
> 
> Feel free. I mean, it is pretty obvious but if it helps, it wouldn't hurt.

OK, at least people tracking this thread got this now.

