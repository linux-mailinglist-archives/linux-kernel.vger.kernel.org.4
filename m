Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10AE7658F67
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Dec 2022 18:10:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233660AbiL2RKf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Dec 2022 12:10:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229773AbiL2RKd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Dec 2022 12:10:33 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34B9665FF
        for <linux-kernel@vger.kernel.org>; Thu, 29 Dec 2022 09:10:32 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id p1-20020a05600c1d8100b003d8c9b191e0so13590621wms.4
        for <linux-kernel@vger.kernel.org>; Thu, 29 Dec 2022 09:10:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6iXEUQF/2BeuvNlDHuWFT5+6QZOEeSuxDVO3QVbXNvA=;
        b=XR0ru+oBYc3oN3vyc9Ob6/Y1TDuoxbKD2u8sKbsHcnCbPnh3aocBcj9V8LxT9OsZvT
         TTCg7jo7VamSs55XaIJxAuuosVqaVNcwuGuWOprI57Y9GsDtcPP7t28Y1fCXIjOTF8ki
         key4JyfC0WoT309l+iM+cmepJxDCKU3IGpxlMbA8KJtb3sqZKlrdvrjCG0QC3dve+yD0
         zrJ0jsGVLGEKhqf9EAcE1+v7NFU5BDbHczvrIAYW9SPu1y8l3CshcjE6M5Ce2WUUSFDJ
         t9qPEgvMmeK/Sk9mhrHuTQNczG5/fIi6gF+hVdDsM/LcesOTwBSzN3hLbcN6+ssKu58Z
         BtIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6iXEUQF/2BeuvNlDHuWFT5+6QZOEeSuxDVO3QVbXNvA=;
        b=7IELI/j3VCNGlaYkiDCM75ppa9dHuw5Z6i9RVgXIureKZ1oHp2NQpvh7cK9jqh+uF6
         Ql8cdFQXzQHtETt9SdcEL05Bz1mqtxz6ZL8Gl3OTUnk56zefee9V2YPqBPwqZnWh1OI6
         L25YhA6Ijt/CfPRs10s5T5sr4yorw79RFZ1WVn3Nbw++gL6VKEAT4NNkRVTEgs1mpaxG
         QNEcmAkzStHf1eWeihkbXX7I0U5xvcsOQI/7048l8cgFv/o7EDWhpd74pN4lOfyXCtUb
         utuYsyY99LBuQR6bhq6KiVP3cYADuk1jbl8iZ+ob7CXb/+iPCU6m/P/Ic06LMz3aey+Q
         Pg/Q==
X-Gm-Message-State: AFqh2kpxSpYmMeYCNFmll1YsoPJF+pjeGCYGVp106lZ7QjxsrXM0iynA
        W8qryl5tlmVxsaRMWMRZvng=
X-Google-Smtp-Source: AMrXdXvlBHWAQSqBO/YIG9QKvKgK4LB2zVDBB9SbqCS4j2rIQ3Wj1hJx3JKsZmsQeILggk9yQrXxsA==
X-Received: by 2002:a05:600c:4255:b0:3d2:282a:e1f5 with SMTP id r21-20020a05600c425500b003d2282ae1f5mr20289099wmm.30.1672333830620;
        Thu, 29 Dec 2022 09:10:30 -0800 (PST)
Received: from localhost ([2a00:23c5:dc8c:8701:fdcf:52c5:7af:c812])
        by smtp.gmail.com with ESMTPSA id n14-20020a5d484e000000b00242814c2cf0sm18873420wrs.4.2022.12.29.09.10.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Dec 2022 09:10:29 -0800 (PST)
Date:   Thu, 29 Dec 2022 17:10:28 +0000
From:   Lorenzo Stoakes <lstoakes@gmail.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Hyeonggon Yoo <42.hyeyoo@gmail.com>, linux-mm@kvack.org,
        liam.howlett@oracle.com, surenb@google.com, ldufour@linux.ibm.com,
        michel@lespinasse.org, vbabka@suse.cz, linux-kernel@vger.kernel.org
Subject: Re: [QUESTION] about the maple tree and current status of mmap_lock
 scalability
Message-ID: <Y63KBNzdOkf3qmBX@murray>
References: <EC51CFA7-2BC8-4F72-A7D4-3B1A778EDB37@gmail.com>
 <Y6ysHNPvKayTfeq8@casper.infradead.org>
 <Y62ipKlWGEbJZKXv@hyeyoo>
 <Y63FmaNoLAcdsLaU@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y63FmaNoLAcdsLaU@casper.infradead.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 29, 2022 at 04:51:37PM +0000, Matthew Wilcox wrote:
> The mmap_lock is taken for many, many things.  [snip]

I am currently describing the use of this lock (for 6.0) in the book and it is
striking just how broadly it's used. I'm diagramming it out for 'core' users,
i.e. non-driver and non-some other things, but even constraining that leaves a
HUGE number of users. I've also documented the 'unexpected' uses of the
page_table_lock, which seems to have been significantly improved over time but
still a few cases remain!

Am happy to give you (+ anybody else on MAINTAINERS list) an early copy of the
relevant bit (once I've finished the diagrams anyway) if that'd be helpful!

Now if you guys could stop obsoleting my work that'd be great ;)
