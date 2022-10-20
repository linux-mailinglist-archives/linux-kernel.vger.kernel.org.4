Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D8BF605FF6
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 14:16:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230023AbiJTMQz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 08:16:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230096AbiJTMQv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 08:16:51 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AE711905E6;
        Thu, 20 Oct 2022 05:16:47 -0700 (PDT)
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29KBq7pB013776;
        Thu, 20 Oct 2022 12:16:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=G5pEjTb2W11m3oZ9DMfyFhpHsGdJyRTiA4oZDkkj9Cw=;
 b=CwPOBYyTLm7oVP4xk4lE0ah2Pdx4w863AONmTmNKW50RUeprZaKbe/Nj8TwGkRQ3DMMt
 tPKLQea2r5imGSj0Zsxd2BKwjTkT0KSyZdO4ZAPrLIhnelHTEOoom3pmnWunX264LlTa
 g8hIm/LxYWhKfMB6z0otha3ZnJRHhkXuulnDEfJa4b22YHOSrG56n2AGAKLE7VmCSXwV
 Ps2uGf0ES8AlturxmbaGXFhIH2uNNwbYJe8cLnVw891Tb3fkG7sMw+3zSTMrZ0PNJHef
 QvilAivxJG31q+ocL8mIM5AlUSoH0MfZhXYNlOKs3G3y5Am6eqYmAGGEqtomOLelCv3U rQ== 
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com [159.122.73.72])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3kb5u8s0ce-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 20 Oct 2022 12:16:28 +0000
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
        by ppma06fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 29KC5hZT030950;
        Thu, 20 Oct 2022 12:16:27 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma06fra.de.ibm.com with ESMTP id 3k7m4jeq0s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 20 Oct 2022 12:16:26 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 29KCBLPx36372762
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 20 Oct 2022 12:11:21 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CAF8EAE051;
        Thu, 20 Oct 2022 12:16:23 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3D7FAAE045;
        Thu, 20 Oct 2022 12:16:23 +0000 (GMT)
Received: from oc-nschnelle.boeblingen.de.ibm.com (unknown [9.155.199.46])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 20 Oct 2022 12:16:23 +0000 (GMT)
Message-ID: <ca76170852152cb9fef207a16b39b67035e5bd28.camel@linux.ibm.com>
Subject: Re: [RFC 1/6] s390/ism: Set DMA coherent mask
From:   Niklas Schnelle <schnelle@linux.ibm.com>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Matthew Rosato <mjrosato@linux.ibm.com>, iommu@lists.linux.dev,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Gerd Bayer <gbayer@linux.ibm.com>,
        Pierre Morel <pmorel@linux.ibm.com>,
        linux-s390@vger.kernel.org, borntraeger@linux.ibm.com,
        hca@linux.ibm.com, gor@linux.ibm.com,
        gerald.schaefer@linux.ibm.com, agordeev@linux.ibm.com,
        svens@linux.ibm.com, linux-kernel@vger.kernel.org,
        Wenjia Zhang <wenjia@linux.ibm.com>,
        Julian Ruess <julianr@linux.ibm.com>
Date:   Thu, 20 Oct 2022 14:16:23 +0200
In-Reply-To: <Y1EB1pvWkoHXQh+a@infradead.org>
References: <20221019144435.369902-1-schnelle@linux.ibm.com>
         <20221019144435.369902-2-schnelle@linux.ibm.com>
         <Y1EB1pvWkoHXQh+a@infradead.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: YL3H8FkwAFmflvy2fXNpq3J6HPheuH9n
X-Proofpoint-ORIG-GUID: YL3H8FkwAFmflvy2fXNpq3J6HPheuH9n
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-20_03,2022-10-20_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 adultscore=0
 priorityscore=1501 phishscore=0 malwarescore=0 spamscore=0 mlxlogscore=761
 impostorscore=0 mlxscore=0 suspectscore=0 clxscore=1015 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2209130000
 definitions=main-2210200072
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2022-10-20 at 01:07 -0700, Christoph Hellwig wrote:
> On Wed, Oct 19, 2022 at 04:44:30PM +0200, Niklas Schnelle wrote:
> >  	if (ret)
> >  		goto err_resource;
> >  
> > +	ret = dma_set_coherent_mask(&pdev->dev, DMA_BIT_MASK(64));
> 
> Nit:  but you could also just replace the call to dma_set_mask abobe with
> a call to dma_set_mask_and_coherent.

That makes sense, thanks. Will be added for v2. Also obviously this
change is only a prerequisite and could be applied separately, the
changed coherent mask won't affect use with the existing DMA
implementation.

