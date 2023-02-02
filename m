Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A805688A90
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 00:14:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233032AbjBBXOf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 18:14:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232341AbjBBXOc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 18:14:32 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC97D23D97
        for <linux-kernel@vger.kernel.org>; Thu,  2 Feb 2023 15:13:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675379627;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=kXVHvL7Zc9SvpXlyodElHL/El9p9PH7Vp09KDuKNQ7k=;
        b=UZSsENMhMyiq0vTVZM7cqcrB4nyoqHJi/tkIFKdWIFh38FBUhz4H/xoZ98ObPRjQwNz/KD
        ur5WN3y4wPiHyavJFKuZxh6kA4DHfc/GvHJEosj1h01G89E+gfy3nR8ipkcfuLeyZgjp0P
        vX/sjuzFbK/LeS3w3cAbiFrt3uq8/Ko=
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com
 [209.85.166.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-433-scBfYTKoMhKyZrRImn2kJQ-1; Thu, 02 Feb 2023 18:13:45 -0500
X-MC-Unique: scBfYTKoMhKyZrRImn2kJQ-1
Received: by mail-il1-f200.google.com with SMTP id x9-20020a056e021ca900b0030f177273c3so2193777ill.8
        for <linux-kernel@vger.kernel.org>; Thu, 02 Feb 2023 15:13:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kXVHvL7Zc9SvpXlyodElHL/El9p9PH7Vp09KDuKNQ7k=;
        b=ex4SB1ta/OIguRAfv/ZYYlXyQfjLNnpWjzLZqCVLgRN0KvTzE8VqevaKyKP2lP1WGg
         nPhtgFybIH12Q5kEZoUxGDNptXnKZYE/SSFMGpWxf2mD3Y6aemXxVZQsteFyEtyhxgw9
         LV0AkiPgp3ICeFooYVODaoGeVEuSAgUlukbAKWC4t6I8kMYYwv66VF9MTW/utQKp3wCm
         b+xZ96CkDzW3duw2214LkeXrR1e4Ve5MhqKZk9sq2ziMBYlCGn/7kahHqQ7Ne+Zwy8mt
         BSS/BWco94SoTrfCpIGrUO5RYS0sYP1V9wj8W39ERVGMuNFan+kHM9sD9PsqYoyYuawa
         9Rqw==
X-Gm-Message-State: AO0yUKV54dAggl2adsdkIR4PR957Y007IrCPBr64MLZVNiYEsBrdVGL+
        EDZDM7q3f+pi3u4zF+W8mZurDOfTpMJhg+iOK6gQ0O900+RcvPP4mArB7iHgQRUro7A3eZv38Xj
        NQkDFt2EpKd6M2tgB7eR3DuIo
X-Received: by 2002:a05:6602:2dc2:b0:707:d9c9:458e with SMTP id l2-20020a0566022dc200b00707d9c9458emr3293884iow.1.1675379625362;
        Thu, 02 Feb 2023 15:13:45 -0800 (PST)
X-Google-Smtp-Source: AK7set8MFntk5bjnEw1nbcEwPglzwxtEbs/VR6tLktByEWuRryxfTh9CCM+W/HuYuBK+h7W/qw1aLw==
X-Received: by 2002:a05:6602:2dc2:b0:707:d9c9:458e with SMTP id l2-20020a0566022dc200b00707d9c9458emr3293860iow.1.1675379625133;
        Thu, 02 Feb 2023 15:13:45 -0800 (PST)
Received: from x1 (c-73-214-169-22.hsd1.pa.comcast.net. [73.214.169.22])
        by smtp.gmail.com with ESMTPSA id a7-20020a5e8e07000000b007192441e5e6sm274085ion.45.2023.02.02.15.13.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Feb 2023 15:13:44 -0800 (PST)
Date:   Thu, 2 Feb 2023 18:13:41 -0500
From:   Brian Masney <bmasney@redhat.com>
To:     Johan Hovold <johan+linaro@kernel.org>
Cc:     Georgi Djakov <djakov@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Artur =?utf-8?B?xZp3aWdvxYQ=?= <a.swigon@samsung.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 11/23] interconnect: qcom: msm8974: fix registration race
Message-ID: <Y9xDpSxL+3Iny+hF@x1>
References: <20230201101559.15529-1-johan+linaro@kernel.org>
 <20230201101559.15529-12-johan+linaro@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230201101559.15529-12-johan+linaro@kernel.org>
User-Agent: Mutt/2.2.7 (2022-08-07)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 01, 2023 at 11:15:47AM +0100, Johan Hovold wrote:
> The current interconnect provider registration interface is inherently
> racy as nodes are not added until the after adding the provider. This
> can specifically cause racing DT lookups to fail.
> 
> Switch to using the new API where the provider is not registered until
> after it has been fully initialised.
> 
> Fixes: 4e60a9568dc6 ("interconnect: qcom: add msm8974 driver")
> Cc: stable@vger.kernel.org      # 5.5
> Cc: Brian Masney <bmasney@redhat.com>
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>

Reviewed-by: Brian Masney <bmasney@redhat.com>

