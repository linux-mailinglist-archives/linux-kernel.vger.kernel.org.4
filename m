Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F58062BEB3
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 13:53:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232807AbiKPMxA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 07:53:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232931AbiKPMw6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 07:52:58 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74BC91B9D2;
        Wed, 16 Nov 2022 04:52:57 -0800 (PST)
Received: from fraeml744-chm.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4NC2vq0HJRz6H74y;
        Wed, 16 Nov 2022 20:50:31 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (7.191.163.240) by
 fraeml744-chm.china.huawei.com (10.206.15.225) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 16 Nov 2022 13:52:55 +0100
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Wed, 16 Nov
 2022 12:52:55 +0000
Date:   Wed, 16 Nov 2022 12:52:54 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     <alison.schofield@intel.com>
CC:     Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>, <linux-cxl@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 6/6] tools/testing/cxl: Mock the Get Poison List mbox
 command
Message-ID: <20221116125254.00003466@Huawei.com>
In-Reply-To: <7accc4b25613bd04ded1c48fa317dcf08803575f.1668115235.git.alison.schofield@intel.com>
References: <cover.1668115235.git.alison.schofield@intel.com>
        <7accc4b25613bd04ded1c48fa317dcf08803575f.1668115235.git.alison.schofield@intel.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml100004.china.huawei.com (7.191.162.219) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 10 Nov 2022 19:12:44 -0800
alison.schofield@intel.com wrote:

> From: Alison Schofield <alison.schofield@intel.com>
> 
> Return fake poison error records when the get poison list mbox
> command is issued. This supports testing the kernel tracing
> and cxl list capabilities for media errors.
> 
> Signed-off-by: Alison Schofield <alison.schofield@intel.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
>  tools/testing/cxl/test/mem.c | 31 +++++++++++++++++++++++++++++++
>  1 file changed, 31 insertions(+)
> 
> diff --git a/tools/testing/cxl/test/mem.c b/tools/testing/cxl/test/mem.c
> index f0704d090073..f729e055605d 100644
> --- a/tools/testing/cxl/test/mem.c
> +++ b/tools/testing/cxl/test/mem.c
> @@ -38,6 +38,10 @@ static struct cxl_cel_entry mock_cel[] = {
>  		.opcode = cpu_to_le16(CXL_MBOX_OP_GET_HEALTH_INFO),
>  		.effect = cpu_to_le16(0),
>  	},
> +	{
> +		.opcode = cpu_to_le16(CXL_MBOX_OP_GET_POISON),
> +		.effect = cpu_to_le16(0),
> +	},
>  };
>  
>  /* See CXL 2.0 Table 181 Get Health Info Output Payload */
> @@ -207,6 +211,30 @@ static int mock_health_info(struct cxl_dev_state *cxlds,
>  	return 0;
>  }
>  
> +static int mock_get_poison(struct cxl_dev_state *cxlds, struct cxl_mbox_cmd *cmd)
> +{
> +	struct {
> +		struct cxl_mbox_poison_payload_out poison_out;
> +		struct cxl_poison_record record;
> +	} mock_poison_list = {
> +		.poison_out = {
> +			.count = cpu_to_le16(1),
> +		},
> +		.record = {
> +			/* .address encodes DPA and poison source bits */
> +			.address = cpu_to_le64(CXL_POISON_SOURCE_INTERNAL),
> +			.length = cpu_to_le32(1),
> +		},
> +	};
> +
> +	if (cmd->size_out < sizeof(mock_poison_list))
> +		return -EINVAL;
> +
> +	memcpy(cmd->payload_out, &mock_poison_list, sizeof(mock_poison_list));
> +	cmd->size_out = sizeof(mock_poison_list);
> +	return 0;
> +}
> +
>  static int cxl_mock_mbox_send(struct cxl_dev_state *cxlds, struct cxl_mbox_cmd *cmd)
>  {
>  	struct device *dev = cxlds->dev;
> @@ -234,6 +262,9 @@ static int cxl_mock_mbox_send(struct cxl_dev_state *cxlds, struct cxl_mbox_cmd *
>  	case CXL_MBOX_OP_GET_HEALTH_INFO:
>  		rc = mock_health_info(cxlds, cmd);
>  		break;
> +	case CXL_MBOX_OP_GET_POISON:
> +		rc = mock_get_poison(cxlds, cmd);
> +		break;
>  	default:
>  		break;
>  	}

