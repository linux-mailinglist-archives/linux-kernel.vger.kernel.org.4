Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7685D645BA7
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 14:59:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230166AbiLGN7I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 08:59:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229812AbiLGN64 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 08:58:56 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 857A239A
        for <linux-kernel@vger.kernel.org>; Wed,  7 Dec 2022 05:57:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1670421476;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3+JlsJ+T+0zmdcrgV//HeWy7oKJHU0vdTnsFfLVk0g0=;
        b=LkjZ0HfNDChwcfCQs/Ycp/dggfhqGa5uEZVoHAkkLezuqf+GMPXDh+3LxZVVBpKI+hT0q8
        QvJW4ffVWT1GOw8droVkHy/3Zl/m1tzi1CCqbK8XfAFJE2mdd96G/VzFA/AI7wFtry52pD
        dd7jGIHW+jyrraJKH3vozwhvtUUAPzI=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-255-2ktB4nM3PwGAN1inS689RA-1; Wed, 07 Dec 2022 08:57:53 -0500
X-MC-Unique: 2ktB4nM3PwGAN1inS689RA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id AC8D43C38FE8;
        Wed,  7 Dec 2022 13:57:52 +0000 (UTC)
Received: from localhost (ovpn-13-181.pek2.redhat.com [10.72.13.181])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id A30E340C2064;
        Wed,  7 Dec 2022 13:57:51 +0000 (UTC)
Date:   Wed, 7 Dec 2022 21:57:48 +0800
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
Message-ID: <Y5Cb3KGDXijyBXfM@MiWiFi-R3L-srv>
References: <20221116214643.6384-1-eric.devolder@oracle.com>
 <20221116214643.6384-4-eric.devolder@oracle.com>
 <Y4A1/cSekXUTFriC@MiWiFi-R3L-srv>
 <Y5BkL8x01KWoF502@zn.tnic>
 <Y5CIvcZLuokwyGYT@MiWiFi-R3L-srv>
 <Y5CKNqtDm5VT+gsz@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y5CKNqtDm5VT+gsz@zn.tnic>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/07/22 at 01:42pm, Borislav Petkov wrote:
> On Wed, Dec 07, 2022 at 08:36:13PM +0800, Baoquan He wrote:
> > Below is my last reply to Eric about my thinking on this.
> 
> Yes, I saw that.
> 
> So think about it: if a CONFIG_ item is not present, what does that mean
> for the code which is enclosed around it?

Ignored by compiler.

I thought we usually need to introduce the kernel config option, then
add code related to it, so that is a wrong idea. It would be helpful to
tell this somewhere in document.

