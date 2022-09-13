Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81B805B6F34
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 16:11:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232694AbiIMOJo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 10:09:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232457AbiIMOIt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 10:08:49 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 632815788C
        for <linux-kernel@vger.kernel.org>; Tue, 13 Sep 2022 07:08:28 -0700 (PDT)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28DDuRxA022424;
        Tue, 13 Sep 2022 14:08:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=date : from : to :
 cc : subject : message-id : mime-version : content-type; s=qcppdkim1;
 bh=Gee9i0tLAhXBmv2PdAiOdWGYIoFuMseV5LWWpVexfSA=;
 b=fdKLH/boMg/+4tmDozRIuZWfB0NqUyzOQygi9uzvkTLrw3YYlfuMq60eChqiI7F5H2oS
 Ci879mKvwhGek7naHR3Fno/TTGS1zaywOB+on0Ed5+6KKl1bn8p8E+5l1FgMEHmQqWcM
 A9DdPYr8uBm92RJqTkUN0opXlP9RPaIJaPuRDIAag/mGzlM4YvIE8WaOEIsIlTUDATSg
 qXrY64blIi/WUWALTmgik8huDAfwnzT8pYhIevR1XBGRu1xp+F6ZrE+BVrJAwEGyzrUK
 /1XuB4TCsDp9vJUhgqhPQCpdUz1pWTcgYiGLWzksyb5SwMY3dlSV6yxGSf53DuUtfYnn Ug== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3jgk6kfq8h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 13 Sep 2022 14:08:24 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 28DE8NFc028516
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 13 Sep 2022 14:08:23 GMT
Received: from hu-pkondeti-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Tue, 13 Sep 2022 07:08:21 -0700
Date:   Tue, 13 Sep 2022 19:38:17 +0530
From:   Pavan Kondeti <quic_pkondeti@quicinc.com>
To:     Johannes Weiner <hannes@cmpxchg.org>,
        Suren Baghdasaryan <surenb@google.com>,
        <linux-kernel@vger.kernel.org>
CC:     <quic_charante@quicinc.com>
Subject: PSI idle-shutoff
Message-ID: <20220913140817.GA9091@hu-pkondeti-hyd.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: z6RgJQ70XD_q-fVZNu1fbm0tt2ieaTjH
X-Proofpoint-ORIG-GUID: z6RgJQ70XD_q-fVZNu1fbm0tt2ieaTjH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-13_05,2022-09-13_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=820 adultscore=0
 mlxscore=0 suspectscore=0 priorityscore=1501 phishscore=0 bulkscore=0
 lowpriorityscore=0 clxscore=1011 impostorscore=0 spamscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2209130064
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

The fact that psi_avgs_work()->collect_percpu_times()->get_recent_times()
run from a kworker thread, PSI_NONIDLE condition would be observed as
there is a RUNNING task. So we would always end up re-arming the work.

If the work is re-armed from the psi_avgs_work() it self, the backing off
logic in psi_task_change() (will be moved to psi_task_switch soon) can't
help. The work is already scheduled. so we don't do anything there.

Probably I am missing some thing here. Can you please clarify how we
shut off re-arming the psi avg work?

Thanks,
Pavan

