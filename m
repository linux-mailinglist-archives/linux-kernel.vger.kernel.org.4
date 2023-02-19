Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E836869C22D
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Feb 2023 20:43:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231370AbjBSTm5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Feb 2023 14:42:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231375AbjBSTmw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Feb 2023 14:42:52 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39B882D6E;
        Sun, 19 Feb 2023 11:42:51 -0800 (PST)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31JHhm7u018988;
        Sun, 19 Feb 2023 19:42:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=CYJ3eVTHiOWV/HXfh9LoWzkEjLJj1zuaaERAokCGMZs=;
 b=bjvkbRBpdRlQYGx8F56LZ84vecCQkZCmXwUUKkStfqw17eZhU5SifB+n2Zi0Mg5Wj9sN
 qF96Ef4o2I+KpYf56z7dDs9QTSrIkIpr1/4kyD4kHcATim1bhy8CcQkJx62tSW4boqZZ
 Ues6C+peWWA9xHhZRSqFAIMoP5eQ4R/eg/4NaeojKtHgD5cvlGuGo2nXcnGU0NoHrTsW
 IX+f7mQr+qCWdlgjEO/7bqygXpVKD3guhiiFnhZwAsHBF4XyZONsk9pFkyhdHZH/Sal7
 Ag7nvl+ztC18vkJm4mOogFRItX/Wo0GYVuwgo9JTa+BvSrgvpmSm0yOLNpsxG/5fxB0g Hg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3nure0sk0g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 19 Feb 2023 19:42:18 +0000
Received: from m0098410.ppops.net (m0098410.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 31JJgHXh023283;
        Sun, 19 Feb 2023 19:42:17 GMT
Received: from ppma02wdc.us.ibm.com (aa.5b.37a9.ip4.static.sl-reverse.com [169.55.91.170])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3nure0sk07-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 19 Feb 2023 19:42:17 +0000
Received: from pps.filterd (ppma02wdc.us.ibm.com [127.0.0.1])
        by ppma02wdc.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 31JIBWxB027705;
        Sun, 19 Feb 2023 19:42:16 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([9.208.130.100])
        by ppma02wdc.us.ibm.com (PPS) with ESMTPS id 3ntpa71404-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 19 Feb 2023 19:42:15 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
        by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 31JJgEqG7078610
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 19 Feb 2023 19:42:15 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C3A3F5804B;
        Sun, 19 Feb 2023 19:42:14 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7700E58059;
        Sun, 19 Feb 2023 19:42:12 +0000 (GMT)
Received: from sig-9-65-218-178.ibm.com (unknown [9.65.218.178])
        by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
        Sun, 19 Feb 2023 19:42:12 +0000 (GMT)
Message-ID: <1f252850086a39e3c15736f252600d388f6b9c24.camel@linux.ibm.com>
Subject: Re: [PATCH v7 6/6] evm: Support multiple LSMs providing an xattr
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Roberto Sassu <roberto.sassu@huaweicloud.com>, mark@fasheh.com,
        jlbec@evilplan.org, joseph.qi@linux.alibaba.com,
        dmitry.kasatkin@gmail.com, paul@paul-moore.com, jmorris@namei.org,
        serge@hallyn.com, stephen.smalley.work@gmail.com,
        eparis@parisplace.org, casey@schaufler-ca.com
Cc:     ocfs2-devel@oss.oracle.com, reiserfs-devel@vger.kernel.org,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        linux-kernel@vger.kernel.org, keescook@chromium.org,
        nicolas.bouchinet@clip-os.org,
        Roberto Sassu <roberto.sassu@huawei.com>
Date:   Sun, 19 Feb 2023 14:42:11 -0500
In-Reply-To: <20221201104125.919483-7-roberto.sassu@huaweicloud.com>
References: <20221201104125.919483-1-roberto.sassu@huaweicloud.com>
         <20221201104125.919483-7-roberto.sassu@huaweicloud.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: ODVa0zNyK55ULMgNIxo86pUffckjabtN
X-Proofpoint-GUID: wle1aPnHdkMlqRQ8wubR02xP9vIsgwYc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-19_12,2023-02-17_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxlogscore=999
 mlxscore=0 spamscore=0 phishscore=0 priorityscore=1501 impostorscore=0
 suspectscore=0 lowpriorityscore=0 malwarescore=0 clxscore=1015
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302190186
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2022-12-01 at 11:41 +0100, Roberto Sassu wrote:
> From: Roberto Sassu <roberto.sassu@huawei.com>
> 
> Currently, evm_inode_init_security() processes a single LSM xattr from
> the array passed by security_inode_init_security(), and calculates the
> HMAC on it and other inode metadata.
> 
> Given that initxattrs() callbacks, called by
> security_inode_init_security(), expect that this array is terminated when
> the xattr name is set to NULL, reuse the same assumption to scan all xattrs
> and to calculate the HMAC on all of them.
> 
> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> Reviewed-by: Casey Schaufler <casey@schaufler-ca.com>


Normally changing the contents of the EVM HMAC calculation would break
existing systems.  Assuming for the time being this is safe, at what
point will it affect backwards compatability?  Should it be documented
now or then?

-- 
thanks,

Mimi

