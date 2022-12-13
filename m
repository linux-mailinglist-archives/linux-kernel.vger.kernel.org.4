Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D155F64B827
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 16:13:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235766AbiLMPNr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 10:13:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235463AbiLMPNp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 10:13:45 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18D1D1B7B8
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 07:13:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1670944382;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Cai/kPU6Om0Z3mVznNAip1TeRWzCftfKM6SJg/6GxNA=;
        b=aFhCjEujZsDDY+q/j8K+SC14nfElygtjVS4Ty7Qnja2kgxI/Lp0fNsSTe9yGX4KBOKKPX6
        Qn5puWaQzvq9bLBzFqYK9ZGjTu2sCDsHu8cngIEiFMNJ8/8WDUqjbetjyPCWLtF9CJVquL
        TX78kZqEaZ1eQ2HI5Jv62tb3uMgRO+c=
Received: from mail-yb1-f200.google.com (mail-yb1-f200.google.com
 [209.85.219.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-124-aCMoXCHRP3WBfrsIqx7wjg-1; Tue, 13 Dec 2022 10:13:00 -0500
X-MC-Unique: aCMoXCHRP3WBfrsIqx7wjg-1
Received: by mail-yb1-f200.google.com with SMTP id n197-20020a25d6ce000000b00702558fba96so16969053ybg.0
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 07:13:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Cai/kPU6Om0Z3mVznNAip1TeRWzCftfKM6SJg/6GxNA=;
        b=PFzYSaZpcOkyZe7rYHkmWj44eU/7QKtYaYtoS7lZk/7Urp/eeHqJKJ73pc8QAp1qw0
         l7OIGLF23jkmzebaCODoK+/mZFDeLOXfj9RlFZPaxPmU3tYitk68wBKUiosAY4le4wqZ
         mKVQ8ehChynKc6aB6yzEiSDVxdibhwaR1q3+IS9fGryhrbYVOu/pmJC222PiXXrLucGU
         DCvYYGZigFBdOyb/Q7HcR3qm4FdC1AtGv9bZdLyocaGoV3knkhTpDF02cm+iKsUWcykz
         /F+84RW8H5dPVQSvXJ9HMVM4/BVDQYFu4EHGlKbGESPfnjLECZyvMgoaOZKWQ8EZLRo+
         WhLw==
X-Gm-Message-State: ANoB5pkOj9EAaBsLhQucQxQlbHiT508hpKH/vtRDKckN7a5LdwKne6j9
        9p20vLgOgtZ127s6MWyvv+0Id2ij5XrCSBDqFvjyoZx6ObDw9NqPVKTN3j5wIoBBaFbGaG+4Vzy
        L+mXgClCAuLEAL8NgDkKQTENR
X-Received: by 2002:a05:7500:5282:b0:eb:1a6a:f948 with SMTP id x2-20020a057500528200b000eb1a6af948mr873492gaa.64.1670944379834;
        Tue, 13 Dec 2022 07:12:59 -0800 (PST)
X-Google-Smtp-Source: AA0mqf5NzRdu025y2d4748W73kp+EyLMKIiqfTuukd8+EaVyn+tsGlN9uJXSm8luhzEZD8YdS96gmQ==
X-Received: by 2002:a05:7500:5282:b0:eb:1a6a:f948 with SMTP id x2-20020a057500528200b000eb1a6af948mr873472gaa.64.1670944379479;
        Tue, 13 Dec 2022 07:12:59 -0800 (PST)
Received: from x1 (c-73-214-169-22.hsd1.pa.comcast.net. [73.214.169.22])
        by smtp.gmail.com with ESMTPSA id bm18-20020a05620a199200b006ff8c632259sm5657149qkb.42.2022.12.13.07.12.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Dec 2022 07:12:58 -0800 (PST)
Date:   Tue, 13 Dec 2022 10:12:57 -0500
From:   Brian Masney <bmasney@redhat.com>
To:     Johan Hovold <johan@kernel.org>
Cc:     andersson@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        konrad.dybcio@linaro.org, robh+dt@kernel.org,
        johan+linaro@kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        ahalaney@redhat.com, echanude@redhat.com, quic_shazhuss@quicinc.com
Subject: Re: [PATCH 1/4] arm64: dts: qcom: sc8280xp: rename i2c5 to i2c21
Message-ID: <Y5iWeTk2zOp9rInx@x1>
References: <20221212182314.1902632-1-bmasney@redhat.com>
 <20221212182314.1902632-2-bmasney@redhat.com>
 <Y5iSDehp72mQPc+h@hovoldconsulting.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y5iSDehp72mQPc+h@hovoldconsulting.com>
User-Agent: Mutt/2.2.7 (2022-08-07)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 13, 2022 at 03:54:05PM +0100, Johan Hovold wrote:
> Note that the node is labelled qup2_i2c5 and not qup_i2c5.
> 
> That is, the QUP nodes are labelled using two indices, and specifically
> 
> 	qup2_i2c5
> 
> would be another name for
> 
> 	qup_i2c21
> 
> if we'd been using such a flat naming scheme (there are 8 engines per
> QUP).
> 
> So there's nothing wrong with how these nodes are currently named, but
> mixing the two scheme as you are suggesting would not be correct.

Hi Johan,

What would I use for the name in the aliases section? Right now I have:

    aliases {
        i2c18 = &qup2_i2c18;
    }

So qup2_i2c18 becomes qup2_i2c2. Would I use the flat naming scheme for
the alias like so?

    aliases {
        i2c18 = &qup2_i2c2;
    }

Brian

