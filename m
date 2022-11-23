Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6247B6364E4
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 16:55:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238768AbiKWPzg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 10:55:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238744AbiKWPzM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 10:55:12 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B599663E9
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 07:54:44 -0800 (PST)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2ANEamNo006969;
        Wed, 23 Nov 2022 15:54:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=en5l9vKJ5raV6A3tiSmwlqj4sApUmyjY9wUlIP3TuR8=;
 b=bIa8Nc3OqvfcwgptPp35+JF9Ll6MuTtEb+OHrJCpCQ5GIfYxyoyl/EaT3+JiEfGTcREn
 lwrsxAFowFYvxd1x+vtwAFRDBGCDiznAmbJmj7xLPBggteeRwM5aUpnm0esAuGlgM1XN
 1kYgAgoyPVS3rjXvhqe59N7obEoXoB0f/cSkWEsiQR3/QBSZ4k5+T7qvHH3JcStRtVXt
 namOpiY8Z0cPCeV9Laq1TuI+KMEkQPu9ijRxOCUKaBS9hpd9PpwnAXdXQptRQkwZAi2s
 GzizKmEQy3aI9uUvApOZ9X6fbabo86K+WuGKvLo9ciiphuG0IPUUZ54n2xnTixIIni4J mg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3m1n2vjnqq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 23 Nov 2022 15:54:34 +0000
Received: from m0098404.ppops.net (m0098404.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 2ANFdJBO015174;
        Wed, 23 Nov 2022 15:54:33 GMT
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3m1n2vjnpv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 23 Nov 2022 15:54:33 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2ANFp52r012445;
        Wed, 23 Nov 2022 15:54:31 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma04ams.nl.ibm.com with ESMTP id 3kxps8x9fp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 23 Nov 2022 15:54:31 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2ANFsSnC2228878
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 23 Nov 2022 15:54:28 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D06DBA4051;
        Wed, 23 Nov 2022 15:54:28 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 91A0CA405D;
        Wed, 23 Nov 2022 15:54:26 +0000 (GMT)
Received: from tarunpc.in.ibm.com (unknown [9.199.157.25])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Wed, 23 Nov 2022 15:54:26 +0000 (GMT)
Date:   Wed, 23 Nov 2022 21:24:23 +0530
From:   Tarun Sahu <tsahu@linux.ibm.com>
To:     Xiu Jianfeng <xiujianfeng@huawei.com>
Cc:     oohall@gmail.com, dan.j.williams@intel.com,
        vishal.l.verma@intel.com, dave.jiang@intel.com,
        ira.weiny@intel.com, aneesh.kumar@linux.ibm.com,
        nvdimm@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] libnvdimm/of_pmem: Fix memory leak in
 of_pmem_region_probe()
Message-ID: <20221123155423.moztu4jdxkbmofp6@tarunpc.in.ibm.com>
References: <20221123150447.194267-1-xiujianfeng@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221123150447.194267-1-xiujianfeng@huawei.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: VC5a0bJW9OkuSnGk_UAa8S9-fQQQIz3v
X-Proofpoint-GUID: c_yZvNX2hDMD7PlNhk6agzTKEvln5zpp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-23_08,2022-11-23_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 impostorscore=0
 adultscore=0 suspectscore=0 spamscore=0 mlxscore=0 bulkscore=0
 phishscore=0 malwarescore=0 mlxlogscore=999 lowpriorityscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211230114
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Look all good to me.

Reviewed-by: Tarun Sahu <tsahu@linux.ibm.com>

On Nov 23 2022, Xiu Jianfeng wrote:
> After changes in commit 49bddc73d15c ("libnvdimm/of_pmem: Provide a unique
> name for bus provider"), @priv->bus_desc.provider_name is no longer a
> const string, but a dynamic string allocated by kstrdup(), it should be
> freed on the error path, and when driver is removed.
> 
> Fixes: 49bddc73d15c ("libnvdimm/of_pmem: Provide a unique name for bus provider")
> Signed-off-by: Xiu Jianfeng <xiujianfeng@huawei.com>
> ---
> v2: check the return value of kstrdup();
> ---
>  drivers/nvdimm/of_pmem.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/nvdimm/of_pmem.c b/drivers/nvdimm/of_pmem.c
> index 10dbdcdfb9ce..08e7f2502479 100644
> --- a/drivers/nvdimm/of_pmem.c
> +++ b/drivers/nvdimm/of_pmem.c
> @@ -31,11 +31,16 @@ static int of_pmem_region_probe(struct platform_device *pdev)
>  		return -ENOMEM;
>  
>  	priv->bus_desc.provider_name = kstrdup(pdev->name, GFP_KERNEL);
> +	if (!priv->bus_desc.provider_name) {
> +		kfree(priv);
> +		return -ENOMEM;
> +	}
>  	priv->bus_desc.module = THIS_MODULE;
>  	priv->bus_desc.of_node = np;
>  
>  	priv->bus = bus = nvdimm_bus_register(&pdev->dev, &priv->bus_desc);
>  	if (!bus) {
> +		kfree(priv->bus_desc.provider_name);
>  		kfree(priv);
>  		return -ENODEV;
>  	}
> @@ -83,6 +88,7 @@ static int of_pmem_region_remove(struct platform_device *pdev)
>  	struct of_pmem_private *priv = platform_get_drvdata(pdev);
>  
>  	nvdimm_bus_unregister(priv->bus);
> +	kfree(priv->bus_desc.provider_name);
>  	kfree(priv);
>  
>  	return 0;
> -- 
> 2.17.1
> 
