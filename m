Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6C926B72E8
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 10:43:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230089AbjCMJnr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 05:43:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229837AbjCMJnf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 05:43:35 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1DF51B33B;
        Mon, 13 Mar 2023 02:43:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678700612; x=1710236612;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=f2jaxRyW4/AFQnjCX1PeRlWlFVAQ0ExRiYHZWktn/p0=;
  b=S0Qh0J8S0tX1pkQB9TETuX8Ry3obFVctBY+3UjbxO7YqM32Vqi0csWEZ
   KLldNionn4wq5MhqmAHFi1/lXd7cWhoAVC7CQIQzmVxFIsku7B9L3XmRT
   uALwDDI21N389cugbSSoK82hvMX706B7lxpUnAe7U+vNw8jx6J8yBZNT9
   qVMIasmxwY/xPhbgRRJ32keR36JwMFM6koUz2+ggIFMULfK7IcJnN5b1z
   hrA3yLsnvpXrsk7MlaZBkZSkkP+6HmImSHcsPKsTS1FU4OWt5IzjGx8gA
   VVUeIW6PYHdBRtw+Gzmk1Lb4dAb9hrt5miN7YyOYf7C6bQIqPtS/6AoDS
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10647"; a="338654236"
X-IronPort-AV: E=Sophos;i="5.98,256,1673942400"; 
   d="scan'208";a="338654236"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2023 02:43:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10647"; a="821884735"
X-IronPort-AV: E=Sophos;i="5.98,256,1673942400"; 
   d="scan'208";a="821884735"
Received: from kuha.fi.intel.com ([10.237.72.185])
  by fmsmga001.fm.intel.com with SMTP; 13 Mar 2023 02:43:26 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Mon, 13 Mar 2023 11:43:26 +0200
Date:   Mon, 13 Mar 2023 11:43:26 +0200
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Neil Armstrong <neil.armstrong@linaro.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 01/12] usb: typec: ucsi: add PMIC Glink UCSI driver
Message-ID: <ZA7wPtttsWlQRpAR@kuha.fi.intel.com>
References: <20230130-topic-sm8450-upstream-pmic-glink-v3-0-4c860d265d28@linaro.org>
 <20230130-topic-sm8450-upstream-pmic-glink-v3-1-4c860d265d28@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230130-topic-sm8450-upstream-pmic-glink-v3-1-4c860d265d28@linaro.org>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Mar 09, 2023 at 02:27:52PM +0100, Neil Armstrong wrote:
> +static void pmic_glink_ucsi_register(struct work_struct *work)
> +{
> +	struct pmic_glink_ucsi *ucsi = container_of(work, struct pmic_glink_ucsi, register_work);
> +
> +	ucsi_register(ucsi->ucsi);
> +}
> +
> +static void pmic_glink_ucsi_callback(const void *data, size_t len, void *priv)
> +{
> +	struct pmic_glink_ucsi *ucsi = priv;
> +	const struct pmic_glink_hdr *hdr = data;
> +
> +	switch (hdr->opcode) {
> +	case UC_UCSI_READ_BUF_REQ:
> +		pmic_glink_ucsi_read_ack(ucsi, data, len);
> +		break;
> +	case UC_UCSI_WRITE_BUF_REQ:
> +		pmic_glink_ucsi_write_ack(ucsi, data, len);
> +		break;
> +	case UC_UCSI_USBC_NOTIFY_IND:
> +		schedule_work(&ucsi->notify_work);
> +		break;
> +	};
> +}
> +
> +static void pmic_glink_ucsi_pdr_notify(void *priv, int state)
> +{
> +	struct pmic_glink_ucsi *ucsi = priv;
> +
> +	if (state == SERVREG_SERVICE_STATE_UP)
> +		schedule_work(&ucsi->register_work);
> +	else if (state == SERVREG_SERVICE_STATE_DOWN)
> +		ucsi_unregister(ucsi->ucsi);
> +}
> +
> +static int pmic_glink_ucsi_probe(struct auxiliary_device *adev,
> +				 const struct auxiliary_device_id *id)
> +{
> +	struct pmic_glink_ucsi *ucsi;
> +	struct device *dev = &adev->dev;
> +
> +	ucsi = devm_kzalloc(dev, sizeof(*ucsi), GFP_KERNEL);
> +	if (!ucsi)
> +		return -ENOMEM;
> +
> +	ucsi->dev = dev;
> +	dev_set_drvdata(dev, ucsi);
> +
> +	INIT_WORK(&ucsi->notify_work, pmic_glink_ucsi_notify);
> +	INIT_WORK(&ucsi->register_work, pmic_glink_ucsi_register);
> +	init_completion(&ucsi->read_ack);
> +	init_completion(&ucsi->write_ack);
> +	init_completion(&ucsi->sync_ack);
> +	mutex_init(&ucsi->lock);
> +
> +	ucsi->ucsi = ucsi_create(dev, &pmic_glink_ucsi_ops);
> +	if (IS_ERR(ucsi->ucsi))
> +		return PTR_ERR(ucsi->ucsi);
> +
> +	ucsi_set_drvdata(ucsi->ucsi, ucsi);
> +
> +	ucsi->client = devm_pmic_glink_register_client(dev,
> +						       PMIC_GLINK_OWNER_USBC,
> +						       pmic_glink_ucsi_callback,
> +						       pmic_glink_ucsi_pdr_notify,
> +						       ucsi);
> +	return PTR_ERR_OR_ZERO(ucsi->client);
> +}
> +
> +static const struct auxiliary_device_id pmic_glink_ucsi_id_table[] = {
> +	{ .name = "pmic_glink.ucsi", },
> +	{},
> +};
> +MODULE_DEVICE_TABLE(auxiliary, pmic_glink_ucsi_id_table);
> +
> +static struct auxiliary_driver pmic_glink_ucsi_driver = {
> +	.name = "pmic_glink_ucsi",
> +	.probe = pmic_glink_ucsi_probe,
> +	.id_table = pmic_glink_ucsi_id_table,
> +};

What happens if you remove the module - I think you need to implement
the remove callback, no?

thanks,

-- 
heikki
