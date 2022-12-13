Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87BB764B7F2
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 15:59:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235846AbiLMO7p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 09:59:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229820AbiLMO7m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 09:59:42 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90FF22098F;
        Tue, 13 Dec 2022 06:59:41 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 438FDB810F8;
        Tue, 13 Dec 2022 14:59:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8A0AC433EF;
        Tue, 13 Dec 2022 14:59:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670943579;
        bh=CvvcVxzxHT3CSYkCAysMeR2g9STIHLwzqNyMN04Vbac=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oKhWwKyl7xO38XSlhb0AkJHhTGTlLhUSDcyrgnbMcjv3RACMe4P4qci7ETOFS3/jI
         diuik2E/c0uosJ3Q9ZfejdX0gdNS9kkH9fm4RjiwR0C6lldJ178P2hpiBpQU8UW6+s
         0N08S3LP4NZ6WveIlWfiE0tf5M8715hOSdB+/C7Cv8pcI4sdHvgzmyzILnSyojD7YN
         y0xRop7Dp/gIxroJFRf+a7/rOV0hIvM+79NB1fbeT2qyj2WW4Xnh5h/G6Td2exgkp5
         49oCXDP3P5iFMseDYHImxDYnVb1nm1LZO9Fb+8aUu6KncmzFBq05vngySwmK/B3JtR
         LEDofz/1QkiSw==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1p56lC-0004nb-JA; Tue, 13 Dec 2022 15:59:59 +0100
Date:   Tue, 13 Dec 2022 15:59:58 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Brian Masney <bmasney@redhat.com>
Cc:     andersson@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        konrad.dybcio@linaro.org, robh+dt@kernel.org,
        johan+linaro@kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        ahalaney@redhat.com, echanude@redhat.com, quic_shazhuss@quicinc.com
Subject: Re: [PATCH 3/4] arm64: dts: qcom: sa8540p-ride: add qup1_i2c15 and
 qup2_i2c18 nodes
Message-ID: <Y5iTbu69TfChCtHA@hovoldconsulting.com>
References: <20221212182314.1902632-1-bmasney@redhat.com>
 <20221212182314.1902632-4-bmasney@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221212182314.1902632-4-bmasney@redhat.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 12, 2022 at 01:23:13PM -0500, Brian Masney wrote:
> Add the necessary nodes in order to get qup1_i2c15 and qup2_i2c18
> functioning on the automotive board and exposed to userspace.
> 
> This work was derived from various patches that Qualcomm delivered
> to Red Hat in a downstream kernel. This change was validated by using
> i2c-tools 4.3.3 on CentOS Stream 9:
> 
> [root@localhost ~]# i2cdetect -l
> i2c-15  i2c             Geni-I2C                                I2C adapter
> i2c-18  i2c             Geni-I2C                                I2C adapter
> 
> [root@localhost ~]# i2cdetect -a -y 15
> Warning: Can't use SMBus Quick Write command, will skip some addresses
>      0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
> 00:
> 10:
> 20:
> 30: -- -- -- -- -- -- -- --
> 40:
> 50: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
> 60:
> 70:
> 
> Bus 18 has the same output. I validated that we get the same output on
> the downstream kernel.
> 
> Signed-off-by: Brian Masney <bmasney@redhat.com>
> ---

> +	qup1_i2c15_default: qup1-i2c15-state {
> +		mux-pins {
> +			pins = "gpio36", "gpio37";
> +			function = "qup15";
> +		};
> +
> +		config-pins {
> +			pins = "gpio36", "gpio37";
> +			drive-strength = <0x02>;

Use decimal notation.

> +			bias-pull-up;
> +		};
> +	};

Johan
