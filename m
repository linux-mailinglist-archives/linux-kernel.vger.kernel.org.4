Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB72A68BAB0
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 11:47:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229996AbjBFKrF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 05:47:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229806AbjBFKrC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 05:47:02 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB487768F;
        Mon,  6 Feb 2023 02:47:01 -0800 (PST)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3166H1Fd031288;
        Mon, 6 Feb 2023 10:46:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=date : from : to :
 cc : subject : message-id : reply-to : references : mime-version :
 content-type : in-reply-to; s=qcppdkim1;
 bh=aCHh43spwV/1Pii0j/iZxs1Y1fpmhenTUzufbRtMQQU=;
 b=c8BH5aUWG3jvGdCu22D+3qwq84ObGe85/laH6dZqgOYSiL40Btaxy/QRPiDD5J1Earvb
 O5/V0eGRNaZAB7Lh3B/ibMvnOoCAOC7UA7L1YIEWotVMZ4Yeyh01AdpAMooyEjO8FV6v
 wen7SctrXC/XYZNRP6XGJA0MwuKYjV1hBARJYqnr4oO/XWnpHaLZrXEG5uiFyx0SmTbq
 gDOMl6LNhpdj+zqIJ+7ewWyLM0WI/HuKjR1yqMZOzkJWO6GnB4okLa4j5UGZGNatxXNI
 teY1uD6p7YcmM1TxXV48DQJYNfNIAwk8RrLiEhalsmmA973cPIKy8ImOHWW4p6tpFq1E Tw== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3nhfreuf9x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Feb 2023 10:46:49 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 316AkmN2018281
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 6 Feb 2023 10:46:48 GMT
Received: from quicinc.com (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Mon, 6 Feb 2023
 02:46:41 -0800
Date:   Mon, 6 Feb 2023 16:16:37 +0530
From:   Srivatsa Vaddagiri <quic_svaddagi@quicinc.com>
To:     Elliot Berman <quic_eberman@quicinc.com>
CC:     Bjorn Andersson <quic_bjorande@quicinc.com>,
        Alex Elder <elder@linaro.org>,
        Murali Nalajala <quic_mnalajal@quicinc.com>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        Carl van Schaik <quic_cvanscha@quicinc.com>,
        Prakruthi Deepak Heragu <quic_pheragu@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v9 23/27] virt: gunyah: Add IO handlers
Message-ID: <20230206104637.GG332@quicinc.com>
Reply-To: Srivatsa Vaddagiri <quic_svaddagi@quicinc.com>
References: <20230120224627.4053418-1-quic_eberman@quicinc.com>
 <20230120224627.4053418-24-quic_eberman@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
In-Reply-To: <20230120224627.4053418-24-quic_eberman@quicinc.com>
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: fbIDtkTLM12OUOr8yiICcuXqyf03ZiuH
X-Proofpoint-GUID: fbIDtkTLM12OUOr8yiICcuXqyf03ZiuH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-02-06_05,2023-02-06_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0
 lowpriorityscore=0 spamscore=0 clxscore=1015 impostorscore=0 mlxscore=0
 malwarescore=0 priorityscore=1501 adultscore=0 mlxlogscore=757
 phishscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2212070000 definitions=main-2302060093
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Elliot Berman <quic_eberman@quicinc.com> [2023-01-20 14:46:22]:

> +static inline bool gh_vm_io_handler_matches(struct gunyah_vm_io_handler *io_hdlr, u64 addr,
> +						u64 len, u64 data)
> +{
> +	u64 mask = BIT_ULL(io_hdlr->len * BITS_PER_BYTE) - 1;
> +
> +	if (io_hdlr->addr != addr)

Isn't this test redundant (given that caller would have performed same test)?

> +		return false;
> +
> +	if (!io_hdlr->datamatch)
> +		return true;
> +
> +	if (io_hdlr->len != len)
> +		return false;
> +
> +	return (data & mask) == (io_hdlr->data & mask);
> +}
> +
> +static struct gunyah_vm_io_handler *gh_vm_mgr_find_io_hdlr(struct gunyah_vm *ghvm, u64 addr,
> +								u64 len, u64 data)
> +{
> +	struct gunyah_vm_io_handler *io_hdlr = NULL;
> +	struct rb_node *root = NULL;
> +
> +	root = ghvm->mmio_handler_root.rb_node;
> +	while (root) {
> +		io_hdlr = rb_entry(root, struct gunyah_vm_io_handler, node);
> +		if (addr < io_hdlr->addr)
> +			root = root->rb_left;
> +		else if (addr > io_hdlr->addr)
> +			root = root->rb_right;
> +		else if (gh_vm_io_handler_matches(io_hdlr, addr, len, data))

In case of handler not matching, don't we need to modify root?
Otherwise we can be stuck in infinite loop here AFAICS.

> +			return io_hdlr;
> +	}
> +	return NULL;
> +}

// snip

> +int gh_vm_mgr_add_io_handler(struct gunyah_vm *ghvm, struct gunyah_vm_io_handler *io_hdlr)
> +{
> +	struct rb_node **root, *parent = NULL;
> +
> +	if (io_hdlr->datamatch &&
> +		(!io_hdlr->len || io_hdlr->len > (sizeof(io_hdlr->data) * BITS_PER_BYTE)))
> +		return -EINVAL;
> +
> +	root = &ghvm->mmio_handler_root.rb_node;
> +	while (*root) {
> +		struct gunyah_vm_io_handler *curr = rb_entry(*root, struct gunyah_vm_io_handler,
> +								node);
> +
> +		parent = *root;
> +		if (io_hdlr->addr < curr->addr)
> +			root = &((*root)->rb_left);
> +		else if (io_hdlr->addr > curr->addr)
> +			root = &((*root)->rb_right);
> +		else

We should allow two io_handlers on the same addr, but with different data
matches I think.

> +			return -EEXIST;
> +	}
> +
> +	rb_link_node(&io_hdlr->node, parent, root);
> +	rb_insert_color(&io_hdlr->node, &ghvm->mmio_handler_root);
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(gh_vm_mgr_add_io_handler);
