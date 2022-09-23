Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07B1D5E74C2
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 09:21:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230431AbiIWHVo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 03:21:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229928AbiIWHVk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 03:21:40 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F132812B498;
        Fri, 23 Sep 2022 00:21:39 -0700 (PDT)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28N6DZe6008103;
        Fri, 23 Sep 2022 07:21:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=56lNF/9jTkvXWJXrrJLrsO70BQPXxl0eZmHnDXsWP9s=;
 b=N2YvrMe6K55G8ubTPDAlSd7h7Xu4HEUclRMydbycAMnZ5essjhBRfL1Q7dcL31g+on+g
 nXdUP0SNagar7nkHruxYHFlYfZlCSJ0r+o9QhZ28Uu0TGD+RZHBlnBYvOf2rire5tcS+
 Wng3OvqQc7lICXauCQxs+uFs+TZtXqzhSaj6P0OqVflVCTFcrqpZPZMJowW6vyMcu46h
 5rX+NTVX/2Rq1sR0jfaU/19vZYOY9pD72/L8Bbtrk5CUZEXG0ArXEq8ItBmRXQUrU1nM
 AHnXJc+hJUy94M8zNXjm3CAgyrejBMUtJZe2/2vluoFRIp2gU7suIe6+Espe9c4tJYes Sw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3js7bdhp5y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 23 Sep 2022 07:21:11 +0000
Received: from m0098419.ppops.net (m0098419.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 28N6fG4S026218;
        Fri, 23 Sep 2022 07:21:10 GMT
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com [159.122.73.72])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3js7bdhp54-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 23 Sep 2022 07:21:10 +0000
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
        by ppma06fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 28N75hX5019258;
        Fri, 23 Sep 2022 07:21:08 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma06fra.de.ibm.com with ESMTP id 3jn5ghnpx1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 23 Sep 2022 07:21:08 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 28N7H1WS31916350
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 23 Sep 2022 07:17:01 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 60086A4055;
        Fri, 23 Sep 2022 07:21:05 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4B9F3A404D;
        Fri, 23 Sep 2022 07:21:05 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Fri, 23 Sep 2022 07:21:05 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 25651)
        id 0A192E08CE; Fri, 23 Sep 2022 09:21:05 +0200 (CEST)
From:   Christian Borntraeger <borntraeger@linux.ibm.com>
To:     peterz@infradead.org
Cc:     bigeasy@linutronix.de, dietmar.eggemann@arm.com,
        ebiederm@xmission.com, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, mgorman@suse.de, mingo@kernel.org,
        oleg@redhat.com, rjw@rjwysocki.net, rostedt@goodmis.org,
        tj@kernel.org, vincent.guittot@linaro.org, will@kernel.org,
        borntraeger@linux.ibm.com, Marc Hartmayer <mhartmay@linux.ibm.com>
Subject: Re: [PATCH v3 6/6] freezer,sched: Rewrite core freezer logic
Date:   Fri, 23 Sep 2022 09:21:04 +0200
Message-Id: <20220923072104.2013212-1-borntraeger@linux.ibm.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220822114649.055452969@infradead.org>
References: <20220822114649.055452969@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: lIJk0dvhlY7fehHnEgbZBjC-KFBu8Mqq
X-Proofpoint-ORIG-GUID: SG7J-Wwp8bEpk6HnRKK6m5lbxEm-WBM_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-23_02,2022-09-22_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 mlxlogscore=893 spamscore=0 bulkscore=0 phishscore=0 priorityscore=1501
 lowpriorityscore=0 impostorscore=0 mlxscore=0 adultscore=0 malwarescore=0
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2209230044
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Peter, 

as a heads-up. This commit (bisected and verified) triggers a
regression in our KVM on s390x CI. The symptom is that a specific
testcase (start a guest with next kernel and a poky ramdisk,
then ssh via vsock into the guest and run the reboot command) now
takes much longer (300 instead of 20 seconds). From a first look
it seems that the sshd takes very long to end during shutdown
but I have not looked into that yet.
Any quick idea?

Christian 
