Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 883B85EF06D
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 10:28:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235160AbiI2I22 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 04:28:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235493AbiI2I1w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 04:27:52 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 226003913B
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 01:27:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1664440061;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zLdCgYT/C6O1UPsWuBUyjWDTSZBFvsOE9ecdHUsmJzc=;
        b=SEykKwlsW1iYBNlX+zTVpUgnMxG3VezvXmI2hO9BTR313e9Qli77FEub5EcQp8xPF0MjCu
        l/V3Q4m9TpszxiBbt+Rzmbl2rT/6VWibIG8mDqUeq1x6/MTZ/7sWjyHxlyf2aW1f2T1LpL
        63xo1JY7HJ7mzGRxfsUMa/dGQ845kpk=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-597-Yf4GiDETPyqFMslRL0TI6A-1; Thu, 29 Sep 2022 04:25:53 -0400
X-MC-Unique: Yf4GiDETPyqFMslRL0TI6A-1
Received: by mail-wm1-f70.google.com with SMTP id k21-20020a7bc415000000b003b4fac53006so200615wmi.3
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 01:25:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=zLdCgYT/C6O1UPsWuBUyjWDTSZBFvsOE9ecdHUsmJzc=;
        b=cX+l6S6Ot0WBHgE1la+5Uwwrk/6zT22HjT4BgRwTnG1IkKGkX1vsVPsUzlikHiXLUP
         LMlRap3nFUB7fqNFAjq8yc27h8kqzFbkFyMYMELeccq7J1pbbryIiHAmCYgG6pC5oWNx
         AkEc+VL+HpggvvL0Y6VWsyjonrrEOE4kI6hboLmIPtpmCGEEIG2+NedzDoxNzhh56EmY
         v1L5sRX/FRpyP3EiFbtmhC854NNPQBpwHxifmzkmiQmzNqYbgwDIU+X2etWLa9zjQUyN
         ezxYm145sj9Mf6NIdfiuuvV6YfZx13PTiqP9ZQf0xQZv5RDfOFxTdSEMn5BsqykFdtiQ
         hFHQ==
X-Gm-Message-State: ACrzQf1OHjsmJlu4j2mmt++h/rUkoQf+SmX6ZLsPkEMofqncnsCcrkud
        u+FUgVfQ71sfcO69MHelVBk0WQSebRc+x5gOoOLcHgYjtDIPnr0v58mQn+AePT0rMgbhlRHwbRr
        0tmQnaX8dEZJSjQ+MSWwYXU4=
X-Received: by 2002:a05:600c:524a:b0:3b5:290:1a7c with SMTP id fc10-20020a05600c524a00b003b502901a7cmr9900374wmb.75.1664439952580;
        Thu, 29 Sep 2022 01:25:52 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM6wcpAEIocAXOhkbxqM4F6A+OFsll7I1AyU4YfuJxFid2xJknGm/yvv4JdjWF47Y+yAXwsaMw==
X-Received: by 2002:a05:600c:524a:b0:3b5:290:1a7c with SMTP id fc10-20020a05600c524a00b003b502901a7cmr9900354wmb.75.1664439952402;
        Thu, 29 Sep 2022 01:25:52 -0700 (PDT)
Received: from localhost (cpc111743-lutn13-2-0-cust979.9-3.cable.virginm.net. [82.17.115.212])
        by smtp.gmail.com with ESMTPSA id a20-20020a05600c069400b003a5fa79007fsm3547322wmn.7.2022.09.29.01.25.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Sep 2022 01:25:51 -0700 (PDT)
Date:   Thu, 29 Sep 2022 09:25:51 +0100
From:   Aaron Tomlin <atomlin@redhat.com>
To:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, joro@8bytes.org, will@kernel.org,
        dwmw2@infradead.org, baolu.lu@linux.intel.com, hpa@zytor.com
Cc:     iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        atomlin@atomlin.com, robin.murphy@arm.com
Subject: Re: [RFC PATCH 1/3] x86/boot/e820: Make __e820__mapped_all() external
Message-ID: <20220929082551.2zrsayd2v3xhot7m@ava.usersys.com>
X-PGP-Key: http://pgp.mit.edu/pks/lookup?search=atomlin%40redhat.com
X-PGP-Fingerprint: 7906 84EB FA8A 9638 8D1E  6E9B E2DE 9658 19CC 77D6
References: <20220611204859.234975-1-atomlin@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220611204859.234975-1-atomlin@redhat.com>
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat 2022-06-11 21:48 +0100, Aaron Tomlin wrote:
> No functional change.
> 
> This patch allows __e820__mapped_all() to be available for
> external use, in preparation to enhance the error message
> generated by arch_rmrr_sanity_check().
> 

Any more feedback?


Kind regards,

-- 
Aaron Tomlin

