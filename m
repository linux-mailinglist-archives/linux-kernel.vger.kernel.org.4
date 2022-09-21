Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC5BC5C0448
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 18:35:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231425AbiIUQfr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 12:35:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231351AbiIUQfM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 12:35:12 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97F149C2F5
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 09:17:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1663777058;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=FfcSWDyvK8gG5N4a1A9EOaJbBSk6wOatfd9ejRCTkqM=;
        b=i3SG3/n9U5uqIDJg1Ytb/pVHWxKNguZ8x+NcF4DRC9WI+zXy5hLyIyV3fKY+9FW0twezt4
        sdFX1Kv1pQs1RKyRAe7lavbpogq8Wlt2cjp45Kh3QN1Op4mppozpe05Yek6KPXd9wSdj3z
        qjDNlrWcNJddIFi4rnfQhAImTdqXKlo=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-99-P6fpMFrNMI6C4KwTX0veUg-1; Wed, 21 Sep 2022 12:17:36 -0400
X-MC-Unique: P6fpMFrNMI6C4KwTX0veUg-1
Received: by mail-ej1-f69.google.com with SMTP id sb32-20020a1709076da000b0077faea20701so3353249ejc.10
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 09:17:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date;
        bh=FfcSWDyvK8gG5N4a1A9EOaJbBSk6wOatfd9ejRCTkqM=;
        b=mHCfHGkrE6ADO4rVjMiuhz/UMo0ygmQVzLomu+BdtQh9H7pmDY/MGukUmp2Jo0ZShA
         xqf0O0E6U57lPNzgTyHKFGB1kENGgpQAQvV+/netE7pHYMzBrpGMHa5es+bYTHDyP+OD
         Y3p6BI72F7hCYi2H005rU+IA8wPl2H98NJ6zb+W3EpsSf4/MBFgzSc0uNWV006DJ9pyJ
         Rz9YQMjAVQ013XeCe/P/3nTcar/MWAkEvrMlsZQPzMGvTCsbHTPDGVSlfcYZRcMj/P3s
         HrU4yfE7hXoOYJxH0nBQrW6mwvqdnqBjOKUK7TUttfoRoIZjWiy+QSZBLrjz0nYsOeB8
         IfCw==
X-Gm-Message-State: ACrzQf124PgBxiyTr08lqDVWfm8b+7gAgvk38TIopPH1cqkYsv1FeAmI
        TeCtm7oJMqFXKkulO2sTBDD8f8IwlLWStKHC71vnIAsJ1s3i2RuxFvt/kPXsEiR5Zb1A8F8GqBq
        ByPYFDYZ9OrB1wLm7ePQ5RV85
X-Received: by 2002:aa7:d617:0:b0:44e:d2de:3fe1 with SMTP id c23-20020aa7d617000000b0044ed2de3fe1mr26164134edr.104.1663777055783;
        Wed, 21 Sep 2022 09:17:35 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM58VTewJJPKmz/ZoiZ0+8xhb98FXISDzqGdAWAP+DQt5crsRNfxwSLeqyF4RjyCWlLrJmoQTA==
X-Received: by 2002:aa7:d617:0:b0:44e:d2de:3fe1 with SMTP id c23-20020aa7d617000000b0044ed2de3fe1mr26164112edr.104.1663777055583;
        Wed, 21 Sep 2022 09:17:35 -0700 (PDT)
Received: from fedora (nat-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id j26-20020a170906255a00b0073dde62713asm1428988ejb.89.2022.09.21.09.17.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Sep 2022 09:17:35 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Sasha Levin <sashal@kernel.org>
Cc:     Michael Kelley <mikelley@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, kys@microsoft.com,
        haiyangz@microsoft.com, sthemmin@microsoft.com,
        decui@microsoft.com, linux-hyperv@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH AUTOSEL 5.19 01/16] Drivers: hv: Never allocate anything
 besides framebuffer from framebuffer memory region
In-Reply-To: <20220921155332.234913-1-sashal@kernel.org>
References: <20220921155332.234913-1-sashal@kernel.org>
Date:   Wed, 21 Sep 2022 18:17:34 +0200
Message-ID: <87illgog69.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sasha Levin <sashal@kernel.org> writes:

> From: Vitaly Kuznetsov <vkuznets@redhat.com>
>
> [ Upstream commit f0880e2cb7e1f8039a048fdd01ce45ab77247221 ]
>

(this comment applies to all stable branches)

While this change seems to be worthy on its own, the underlying issue
with Gen1 Hyper-V VMs won't be resolved without 

commit 2a8a8afba0c3053d0ea8686182f6b2104293037e
Author: Vitaly Kuznetsov <vkuznets@redhat.com>
Date:   Sat Aug 27 15:03:44 2022 +0200

    Drivers: hv: Always reserve framebuffer region for Gen1 VMs

as 'fb_mmio' is still going to be unset in some cases without it.

-- 
Vitaly

