Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F1916BC47A
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 04:19:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230137AbjCPDTE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 23:19:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229971AbjCPDSY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 23:18:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9F7B9EF76;
        Wed, 15 Mar 2023 20:18:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6951061EE9;
        Thu, 16 Mar 2023 03:18:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72F7DC433A4;
        Thu, 16 Mar 2023 03:18:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678936683;
        bh=Qm5Ur38BpTJHroeStviYqmiOFIHpN6p/X5+Dpllm/E4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qN2QpoP95cEzjpnwJ/E7uzCpW8lW7m/RHkBASzz9ODIqxif8uTO8jtSi8FtclAYk3
         vxr1HA9em2hA+W25kRwkg7xXmrixrKsuXNN7gaRd+LVStyIaerrgaUELaIMKAk977Q
         vqx4fK/1BDRNwnEkOt3cNL5maLT9yzKVrDgWYFMHpio/y/9pl0XS1Nm0XUodxSzXU6
         sG5yxV0olx3qiD1GHnN5CvzwGmWifRU2j/F4YPQKOkZblHTf7inPzuZDMz5XC5g6SF
         +WGkadQjBhUFw6xq1IDDDEp9H5mti7FcSUPqBIJySCGGAqFh/0xbtASRmZOMTd7FLY
         OnmtkVBVY/qlQ==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        Mike Leach <mike.leach@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Konrad Dybcio <konradybcio@gmail.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Mao Jinlong <quic_jinlmao@quicinc.com>
Cc:     linux-kernel@vger.kernel.org, Leo Yan <leo.yan@linaro.org>,
        linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        Hao Zhang <quic_hazha@quicinc.com>,
        Tingwei Zhang <quic_tingweiz@quicinc.com>,
        Tao Zhang <quic_taozha@quicinc.com>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        coresight@lists.linaro.org,
        Yuanfang Zhang <quic_yuanfang@quicinc.com>
Subject: Re: (subset) [PATCH v17 0/9] Coresight: Add support for TPDM and TPDA
Date:   Wed, 15 Mar 2023 20:21:03 -0700
Message-Id: <167893686408.303819.7828285353950827808.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230117145708.16739-1-quic_jinlmao@quicinc.com>
References: <20230117145708.16739-1-quic_jinlmao@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 17 Jan 2023 06:56:59 -0800, Mao Jinlong wrote:
> This series adds support for the trace performance monitoring and
> diagnostics hardware (TPDM and TPDA). It is composed of two major
> elements.
> a) Changes for original coresight framework to support for TPDM and TPDA.
> b) Add driver code for TPDM and TPDA.
> 
> Introduction of changes for original coresight framework
> Support TPDM as new coresight source.
> Since only STM and ETM are supported as coresight source originally.
> TPDM is a newly added coresight source. We need to change
> the original way of saving coresight path to support more types source
> for coresight driver.
> The following patch is to add support more coresight sources.
>     coresight: core: Use IDR for non-cpu bound sources' paths.
> 
> [...]

Applied, thanks!

[9/9] arm64: dts: qcom: sm8250: Add tpdm mm/prng
      commit: fb1fe1542a12e4694e05fe14d4003f828515700c

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
