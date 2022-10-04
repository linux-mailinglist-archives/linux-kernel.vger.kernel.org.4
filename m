Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50E8D5F497F
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 20:53:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229758AbiJDSxB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 14:53:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229760AbiJDSwp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 14:52:45 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 129346AA39;
        Tue,  4 Oct 2022 11:52:37 -0700 (PDT)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 294F8Tef026458;
        Tue, 4 Oct 2022 18:52:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=date : from : to :
 cc : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=qcppdkim1; bh=zzbBuykHboidDhljzKC9UhaXjiSeCNufM3SCTwx7jYo=;
 b=Rh0IVUe/vCAPMaEzssEuy6lxbfgr2OJgefuUF+i+IDFhikPdXOdXZQmRy8wra8zsqxC6
 KWF65NCiXu6tfRayFz61rAsWJN9Uyg58g6jKtsYQyhjtcy8F4nCOlD9uGk2tBaqjKjWn
 sOt6etq9pXvp3Wjtz6Uav2s/pJTJMdxltMd6Uf3+iM9HZ1HEu3uxntVx/HErQfKkuewX
 bd7INt+LM4CTReTJeJUIQtOYGQXa6919/u1GBiCc49berR35yrx8fxWi6hgnIfa3MukR
 wp40QxcXULePIPZ8HPKQJKZSNqqWKbLtYwM0HocID7oKhOomND+c7x2H7xxJbwPh7+dk iQ== 
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3k0escskkx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 04 Oct 2022 18:52:01 +0000
Received: from nasanex01a.na.qualcomm.com (corens_vlan604_snip.qualcomm.com [10.53.140.1])
        by NASANPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 294Iq0De002119
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 4 Oct 2022 18:52:00 GMT
Received: from asutoshd-linux1.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Tue, 4 Oct 2022 11:52:00 -0700
Date:   Tue, 4 Oct 2022 11:51:59 -0700
From:   Asutosh Das <quic_asutoshd@quicinc.com>
To:     Bart Van Assche <bvanassche@acm.org>
CC:     <mani@kernel.org>, <quic_nguyenb@quicinc.com>,
        <quic_xiaosenh@quicinc.com>, <quic_cang@quicinc.com>,
        <quic_nitirawa@quicinc.com>, <quic_rampraka@quicinc.com>,
        <quic_richardp@quicinc.com>, <stanley.chu@mediatek.com>,
        <adrian.hunter@intel.com>, <avri.altman@wdc.com>,
        <beanhuo@micron.com>, <martin.petersen@oracle.com>,
        <linux-scsi@vger.kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        open list <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>
Subject: Re: [PATCH v1 03/16] ufs: core: Defer adding host to scsi if mcq is
 supported
Message-ID: <20221004185159.GB25671@asutoshd-linux1.qualcomm.com>
References: <cover.1663894792.git.quic_asutoshd@quicinc.com>
 <197a8bcca288f9c36586099aa07606ed3f067c9b.1663894792.git.quic_asutoshd@quicinc.com>
 <4767355d-e7b0-d38b-88f3-c070ed0b5e5b@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Content-Disposition: inline
In-Reply-To: <4767355d-e7b0-d38b-88f3-c070ed0b5e5b@acm.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: cWhwDJ6lki4eghnjMnQjS6I_7wh4dhvX
X-Proofpoint-ORIG-GUID: cWhwDJ6lki4eghnjMnQjS6I_7wh4dhvX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-10-04_08,2022-09-29_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 mlxscore=0
 lowpriorityscore=0 malwarescore=0 adultscore=0 mlxlogscore=999
 phishscore=0 bulkscore=0 clxscore=1015 impostorscore=0 priorityscore=1501
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210040122
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 30 2022 at 11:32 -0700, Bart Van Assche wrote:
>On 9/22/22 18:05, Asutosh Das wrote:
>>@@ -8218,6 +8219,14 @@ static int ufshcd_probe_hba(struct ufs_hba *hba, bool init_dev_params)
>>  		ret = ufshcd_device_params_init(hba);
>>  		if (ret)
>>  			goto out;
>>+
>>+		if (is_mcq_supported(hba)) {
>>+			ret = scsi_add_host(host, hba->dev);
>>+			if (ret) {
>>+				dev_err(hba->dev, "scsi_add_host failed\n");
>>+				goto out;
>>+			}
>>+		}
>>  	}
>
>Calling scsi_add_host() from ufshcd_probe_hba() seems wrong to me 
>since that function is not only called when probing a host controller 
>but also when resetting a host controller. See also 
>ufshcd_host_reset_and_restore().
>
The scsi_add_host() is only invoked from ufshcd_probe_hba() if init_dev_params
is true. That flag is false when ufshcd_probe_hba() is invoked from
ufshcd_host_reset_and_restore(). So scsi_add_host() won't be invoked from
ufshcd_host_reset_and_restore(). Even ufshcd_device_params_init() is invoked the
same way now.

>>  	ufshcd_tune_unipro_params(hba);
>>@@ -9764,10 +9773,12 @@ int ufshcd_init(struct ufs_hba *hba, void __iomem *mmio_base, unsigned int irq)
>>  		hba->is_irq_enabled = true;
>>  	}
>>-	err = scsi_add_host(host, hba->dev);
>>-	if (err) {
>>-		dev_err(hba->dev, "scsi_add_host failed\n");
>>-		goto out_disable;
>>+	if (!is_mcq_supported(hba)) {
>>+		err = scsi_add_host(host, hba->dev);
>>+		if (err) {
>>+			dev_err(hba->dev, "scsi_add_host failed\n");
>>+			goto out_disable;
>>+		}
>>  	}
>>  	hba->tmf_tag_set = (struct blk_mq_tag_set) {
>
>Please make sure there is only a single scsi_add_host() call in the 
>UFS host controller driver.
>
One way would be to move the scsi_add_host() to ufshcd_probe_hba().
PLMK if you think this is not OK.

>Thanks,
>
>Bart.
