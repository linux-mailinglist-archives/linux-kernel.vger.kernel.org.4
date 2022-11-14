Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25344628AAA
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 21:43:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237179AbiKNUnu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 15:43:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237077AbiKNUns (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 15:43:48 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44231B498
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 12:42:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1668458569;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=LbWjPGYhr+GO1H5x0EkUkfhuZivLdlj/zRgU+tW9BQ0=;
        b=MXTNb2oB0xcmVqd0QMFNoz5h4VEfNKe+i/Qw6uDeutkP7MzjmMAbvRSOV30uSJRnEgTNlO
        dgyWtPjrNJVIssGl8Q+YqLFlJOQZ6hmg/UeEE7ZgvGFEdgtJ2LNPIOZfo7YKi/VhDVPIW5
        A0gvUu7yt4GLxGgvEAkzmD0AuwphhE0=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-633-gPpZRRxtPg-9FxVj91VvQA-1; Mon, 14 Nov 2022 15:42:47 -0500
X-MC-Unique: gPpZRRxtPg-9FxVj91VvQA-1
Received: by mail-qt1-f200.google.com with SMTP id u31-20020a05622a199f00b003a51fa90654so8807016qtc.19
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 12:42:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LbWjPGYhr+GO1H5x0EkUkfhuZivLdlj/zRgU+tW9BQ0=;
        b=TK/gahiZwjG/eu38Ehzbz51Ktw9PgA34WvZoZmDNnFe2pFegQqPVDIRdk5VgHcb+XX
         HcqBEGGThMDZBrk2mKwrXNpHQFEL8+T4gcuzYNEk90R5Ta3BcM9W2S9o4EUPjfy9K+Ew
         +aWx2yiNoaHZJuacwowVH8wQk4hEIZTJCKgpe7AVjoDjun5H+YP1cshoBkjwa59n8sAf
         HTQcH2TdcWqoVggFrOUQqSay89E3W/Mg3fqOfNjekZF5V5uSfvldYhkCm4Vj8z5CZpNj
         hbxhqm7iqdfpfk9hCA6/dXuhXAkbzK2KmHwt/zUP+Wt/U0+80/YEIqDhrSKSfeXepM2a
         ridg==
X-Gm-Message-State: ANoB5pkGQfdyMVzIQJ31CuTLVfeuzKKpw0N2RFTmlZb4fZd+qJEpHQ+F
        uZ9fuRvLytcDj8nGJsCJ9/j0EhOHWoY3NVwPXZXtEMvlp1kNyz54AihI7uPp6FZaB8GDnHg3g8v
        NkM/EKkyZXdg2aGhRr/GpSC5O
X-Received: by 2002:a05:620a:909:b0:6fa:e58e:f32b with SMTP id v9-20020a05620a090900b006fae58ef32bmr13332614qkv.739.1668458567433;
        Mon, 14 Nov 2022 12:42:47 -0800 (PST)
X-Google-Smtp-Source: AA0mqf7C5iPdOS7Y7CDRc1SZGacqtA4vD0Ot5AYZigwkzzm705pOdGXhMaQJbKJaIAOm+XVaX0Wwvg==
X-Received: by 2002:a05:620a:909:b0:6fa:e58e:f32b with SMTP id v9-20020a05620a090900b006fae58ef32bmr13332591qkv.739.1668458567223;
        Mon, 14 Nov 2022 12:42:47 -0800 (PST)
Received: from x1 (c-73-214-169-22.hsd1.pa.comcast.net. [73.214.169.22])
        by smtp.gmail.com with ESMTPSA id h5-20020ac85685000000b003a4ec43f2b5sm6069969qta.72.2022.11.14.12.42.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Nov 2022 12:42:46 -0800 (PST)
Date:   Mon, 14 Nov 2022 15:42:45 -0500
From:   Brian Masney <bmasney@redhat.com>
To:     Johan Hovold <johan+linaro@kernel.org>
Cc:     Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shazad Hussain <quic_shazhuss@quicinc.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] arm64: dts: qcom: sc8280xp: update UFS PHY nodes
Message-ID: <Y3KoRULjQCYK+H3+@x1>
References: <20221104092045.17410-1-johan+linaro@kernel.org>
 <20221104092045.17410-3-johan+linaro@kernel.org>
 <Y3J4YGPsn8D9wzny@x1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y3J4YGPsn8D9wzny@x1>
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

On Mon, Nov 14, 2022 at 12:18:24PM -0500, Brian Masney wrote:
> On Fri, Nov 04, 2022 at 10:20:45AM +0100, Johan Hovold wrote:
> > Update the UFS PHY nodes to match the new binding.
> > 
> > Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> 
> This is needed in order to boot the sa8540p on linux-next-20221110.

Actually, I take that back... This is not needed to boot on -next. There
was a separate problem on the latest -next that I describe at:

https://lore.kernel.org/linux-arm-msm/20221114202943.2389489-1-bmasney@redhat.com/T/#u

My Reviewed-by still applies for the patch.

Brian

