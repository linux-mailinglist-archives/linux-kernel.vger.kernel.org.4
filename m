Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70A296313E1
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Nov 2022 13:19:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229618AbiKTMTy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Nov 2022 07:19:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbiKTMTo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Nov 2022 07:19:44 -0500
Received: from smtp.smtpout.orange.fr (smtp-19.smtpout.orange.fr [80.12.242.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A08FE3C6F7
        for <linux-kernel@vger.kernel.org>; Sun, 20 Nov 2022 04:19:42 -0800 (PST)
Received: from [192.168.1.18] ([86.243.100.34])
        by smtp.orange.fr with ESMTPA
        id wjIPoqSZxFUJ3wjIPoqDBa; Sun, 20 Nov 2022 13:19:39 +0100
X-ME-Helo: [192.168.1.18]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sun, 20 Nov 2022 13:19:39 +0100
X-ME-IP: 86.243.100.34
Message-ID: <6b68b7c2-e070-0a88-35ee-2060dcbdee91@wanadoo.fr>
Date:   Sun, 20 Nov 2022 13:19:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH v4 3/3] interconnect: qcom: Add QDU1000/QRU1000
 interconnect driver
To:     Melody Olvera <quic_molvera@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Georgi Djakov <djakov@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Odelu Kukatla <quic_okukatla@quicinc.com>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221118182245.31035-1-quic_molvera@quicinc.com>
 <20221118182245.31035-4-quic_molvera@quicinc.com>
Content-Language: fr
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <20221118182245.31035-4-quic_molvera@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 18/11/2022 à 19:22, Melody Olvera a écrit :
> Add interconnect provider driver for Qualcomm QDU1000 and QRU1000
> platforms.
> 
> Signed-off-by: Melody Olvera <quic_molvera@quicinc.com>
> ---
>   drivers/interconnect/qcom/Kconfig   |    9 +
>   drivers/interconnect/qcom/Makefile  |    2 +
>   drivers/interconnect/qcom/qdu1000.c | 1079 +++++++++++++++++++++++++++
>   drivers/interconnect/qcom/qdu1000.h |   95 +++
>   4 files changed, 1185 insertions(+)
>   create mode 100644 drivers/interconnect/qcom/qdu1000.c
>   create mode 100644 drivers/interconnect/qcom/qdu1000.h
> 

[...]

> +static int qnoc_probe(struct platform_device *pdev)
> +{
> +	int ret;
> +
> +	ret = qcom_icc_rpmh_probe(pdev);
> +	if (ret)
> +		dev_err(&pdev->dev, "failed to register ICC provider\n");
> +
> +	return ret;
> +}
> +
> +static int qnoc_remove(struct platform_device *pdev)
> +{
> +	struct qcom_icc_provider *qp = platform_get_drvdata(pdev);
> +
> +	icc_nodes_remove(&qp->provider);
> +	icc_provider_del(&qp->provider);

qcom_icc_rpmh_remove()?

(more future proof, less verbose and more consistent with 
qcom_icc_rpmh_probe() in the probe)

CJ

> +
> +	return 0;
> +}
> +
> +static const struct of_device_id qnoc_of_match[] = {
> +	{ .compatible = "qcom,qdu1000-clk-virt",
> +	  .data = &qdu1000_clk_virt
> +	},
> +	{ .compatible = "qcom,qdu1000-gem-noc",
> +	  .data = &qdu1000_gem_noc
> +	},
> +	{ .compatible = "qcom,qdu1000-mc-virt",
> +	  .data = &qdu1000_mc_virt
> +	},
> +	{ .compatible = "qcom,qdu1000-system-noc",
> +	  .data = &qdu1000_system_noc
> +	},
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, qnoc_of_match);
> +
> +static struct platform_driver qnoc_driver = {
> +	.probe = qnoc_probe,
> +	.remove = qnoc_remove,
> +	.driver = {
> +		.name = "qnoc-qdu1000",
> +		.of_match_table = qnoc_of_match,
> +	},
> +};

[...]

