Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FD91743349
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 05:42:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232099AbjF3DmS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 23:42:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229720AbjF3DmO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 23:42:14 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78F582681;
        Thu, 29 Jun 2023 20:42:12 -0700 (PDT)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35U3dYZa018520;
        Fri, 30 Jun 2023 03:41:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=date : from : to :
 cc : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=qcppdkim1; bh=seQ2j0gbJ727u3DPmbrPvnp+QMoIsDD6zoTAV/LLxGs=;
 b=k7/67pWnKxiivIUzpZLXHAvhD9aOhk1TEi12M1YYgewLaU2xMvnyILcWV2fIVpLNyNip
 zVWgOPbthu/NaQ/D0mWU7TTrtPgU2KF7t0aFi4g9k40CGPbTaHbtIPyg9xaDG2s37cJq
 FJQe/ESik6zPQqGhuHBCGxPuJb8RsQw8zVUqBu+X/7iHWm78tLWYlJAExZzzRP/DOFUM
 /YPL+vUXfpE1otUzLL+EnpqXEMwpv0u2itErpRTMNPRHPoo/7ehiV4A52wiFZwT8x7hM
 BpdH8FpsYeNRh5sNXmFgKR/eTNVjdooUFLW6oOdOquMAhdsZ1nGQWP1F5Jh//U2iMEFQ Dg== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rh0aajpd6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 30 Jun 2023 03:41:47 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 35U3fjTk004090
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 30 Jun 2023 03:41:45 GMT
Received: from hu-pkondeti-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.7; Thu, 29 Jun 2023 20:41:38 -0700
Date:   Fri, 30 Jun 2023 09:11:34 +0530
From:   Pavan Kondeti <quic_pkondeti@quicinc.com>
To:     Mukesh Ojha <quic_mojha@quicinc.com>
CC:     Pavan Kondeti <quic_pkondeti@quicinc.com>, <corbet@lwn.net>,
        <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <keescook@chromium.org>, <tony.luck@intel.com>,
        <gpiccoli@igalia.com>, <mathieu.poirier@linaro.org>,
        <catalin.marinas@arm.com>, <will@kernel.org>,
        <linus.walleij@linaro.org>, <andy.shevchenko@gmail.com>,
        <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-hardening@vger.kernel.org>,
        <linux-remoteproc@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-gpio@vger.kernel.org>
Subject: Re: [PATCH v4 13/21] remoterproc: qcom: refactor to leverage
 exported minidump symbol
Message-ID: <5976b2a5-6ff4-4d1d-8d8a-dca783f49799@quicinc.com>
References: <1687955688-20809-1-git-send-email-quic_mojha@quicinc.com>
 <1687955688-20809-14-git-send-email-quic_mojha@quicinc.com>
 <f1581356-97ba-4faa-8e1c-0d5c7ba994e3@quicinc.com>
 <cd4b7be5-4cfd-e330-458d-3e22019839b9@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <cd4b7be5-4cfd-e330-458d-3e22019839b9@quicinc.com>
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: fcztJk2Fzuuq4shNAq7buAclqPcMp1p1
X-Proofpoint-ORIG-GUID: fcztJk2Fzuuq4shNAq7buAclqPcMp1p1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-30_01,2023-06-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0
 priorityscore=1501 phishscore=0 spamscore=0 lowpriorityscore=0
 suspectscore=0 mlxscore=0 clxscore=1015 impostorscore=0 mlxlogscore=842
 malwarescore=0 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2305260000 definitions=main-2306300030
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 29, 2023 at 02:50:34PM +0530, Mukesh Ojha wrote:
> 
> 
> On 6/28/2023 9:21 PM, Pavan Kondeti wrote:
> > On Wed, Jun 28, 2023 at 06:04:40PM +0530, Mukesh Ojha wrote:
> > > -static int qcom_add_minidump_segments(struct rproc *rproc, struct minidump_subsystem *subsystem,
> > > -			void (*rproc_dumpfn_t)(struct rproc *rproc, struct rproc_dump_segment *segment,
> > > -				void *dest, size_t offset, size_t size))
> > > +void qcom_minidump(struct rproc *rproc, unsigned int minidump_id,
> > > +		void (*rproc_dumpfn_t)(struct rproc *rproc,
> > > +		struct rproc_dump_segment *segment, void *dest, size_t offset,
> > > +		size_t size))
> > >   {
> > > -	struct minidump_region __iomem *ptr;
> > > -	struct minidump_region region;
> > > -	int seg_cnt, i;
> > >   	dma_addr_t da;
> > >   	size_t size;
> > > +	int seg_cnt;
> > >   	char *name;
> > > +	void *ptr;
> > > +	int ret;
> > > +	int i;
> > >   	if (WARN_ON(!list_empty(&rproc->dump_segments))) {
> > >   		dev_err(&rproc->dev, "dump segment list already populated\n");
> > > -		return -EUCLEAN;
> > > +		return;
> > >   	}
> > > -	seg_cnt = le32_to_cpu(subsystem->region_count);
> > > -	ptr = ioremap((unsigned long)le64_to_cpu(subsystem->regions_baseptr),
> > > -		      seg_cnt * sizeof(struct minidump_region));
> > > +	ptr = qcom_ss_md_mapped_base(minidump_id, &seg_cnt);
> > >   	if (!ptr)
> > > -		return -EFAULT;
> > > +		return;
> > >   	for (i = 0; i < seg_cnt; i++) {
> > > -		memcpy_fromio(&region, ptr + i, sizeof(region));
> > > -		if (le32_to_cpu(region.valid) == MINIDUMP_REGION_VALID) {
> > > -			name = kstrndup(region.name, MAX_REGION_NAME_LENGTH - 1, GFP_KERNEL);
> > > -			if (!name) {
> > > -				iounmap(ptr);
> > > -				return -ENOMEM;
> > > -			}
> > > -			da = le64_to_cpu(region.address);
> > > -			size = le64_to_cpu(region.size);
> > > -			rproc_coredump_add_custom_segment(rproc, da, size, rproc_dumpfn_t, name);
> > > +		ret = qcom_ss_valid_segment_info(ptr, i, &name, &da, &size);
> > > +		if (ret < 0) {
> > > +			iounmap(ptr);
> > > +			dev_err(&rproc->dev,
> > > +				"Failed with error: %d while adding minidump entries\n",
> > > +				ret);
> > > +			goto clean_minidump;
> > >   		}
> > > -	}
> > > -
> > > -	iounmap(ptr);
> > > -	return 0;
> > > -}
> > > -
> > > -void qcom_minidump(struct rproc *rproc, unsigned int minidump_id,
> > > -		void (*rproc_dumpfn_t)(struct rproc *rproc,
> > > -		struct rproc_dump_segment *segment, void *dest, size_t offset,
> > > -		size_t size))
> > > -{
> > > -	int ret;
> > > -	struct minidump_subsystem *subsystem;
> > > -	struct minidump_global_toc *toc;
> > > -
> > > -	/* Get Global minidump ToC*/
> > > -	toc = qcom_smem_get(QCOM_SMEM_HOST_ANY, SBL_MINIDUMP_SMEM_ID, NULL);
> > > -
> > > -	/* check if global table pointer exists and init is set */
> > > -	if (IS_ERR(toc) || !toc->status) {
> > > -		dev_err(&rproc->dev, "Minidump TOC not found in SMEM\n");
> > > -		return;
> > > -	}
> > > -	/* Get subsystem table of contents using the minidump id */
> > > -	subsystem = &toc->subsystems[minidump_id];
> > > -
> > > -	/**
> > > -	 * Collect minidump if SS ToC is valid and segment table
> > > -	 * is initialized in memory and encryption status is set.
> > > -	 */
> > > -	if (subsystem->regions_baseptr == 0 ||
> > > -	    le32_to_cpu(subsystem->status) != 1 ||
> > > -	    le32_to_cpu(subsystem->enabled) != MINIDUMP_SS_ENABLED ||
> > > -	    le32_to_cpu(subsystem->encryption_status) != MINIDUMP_SS_ENCR_DONE) {
> > > -		dev_err(&rproc->dev, "Minidump not ready, skipping\n");
> > > -		return;
> > > +		/* if it is a valid segment */
> > > +		if (!ret)
> > > +			rproc_coredump_add_custom_segment(rproc, da, size,
> > > +							  rproc_dumpfn_t, name);
> > >   	}
> > > -	ret = qcom_add_minidump_segments(rproc, subsystem, rproc_dumpfn_t);
> > > -	if (ret) {
> > > -		dev_err(&rproc->dev, "Failed with error: %d while adding minidump entries\n", ret);
> > > -		goto clean_minidump;
> > > -	}
> > > +	iounmap(ptr);
> > >   	rproc_coredump_using_sections(rproc);
> > > +
> > >   clean_minidump:
> > >   	qcom_minidump_cleanup(rproc);
> > >   }
> > 
> > I like the idea of moving minidump pieces to drivers/soc/qcom/*minidump*.
> > 
> > Is it possible to accept one function callback from remoteproc and do
> > all of this in one function exported by minidump?
> > 
> > qcom_ss_valid_segment_info() seems a low level function to be exported..
> 
> It was ending up with circular dependency due to
> rproc_coredump_add_custom_segment()
> 
> 
> rproc_coredump => qcom_common => qcom_minidump_smem => rproc_coredump
> 

Where is the circular dependency here? Any API accepting callback would
end up like below

caller -> API(callback) -> (*callback) -> [in caller code ...]

May be I am missing something here.

AFAICS, the minidump could do everything except it does not know how to
create a segment and add it to rproc::dump_segments list. Is it not
possible to write a minidump API that accepts a callback and a list
head? we may not probably re-use rproc_coredump_add_custom_segment() as
is, but some refactoring allows/covers both cases..Pls give it a
thought.

This way we don't need to create an internal API like below

int qcom_ss_valid_segment_info(void *ptr, int i, char **name, dma_addr_t
*da, size_t *size)

Thanks,
Pavan
