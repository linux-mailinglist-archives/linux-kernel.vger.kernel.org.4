Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98FC466AF3A
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Jan 2023 04:58:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230506AbjAOD6L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Jan 2023 22:58:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230003AbjAOD6J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Jan 2023 22:58:09 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E439DB74A;
        Sat, 14 Jan 2023 19:58:07 -0800 (PST)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30F3veBa008990;
        Sun, 15 Jan 2023 03:57:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : to : cc : from : subject : content-type :
 content-transfer-encoding; s=qcppdkim1;
 bh=jtc+dxZTScazwf6CJliIJoikyEQ1LzERekxuaplZUWo=;
 b=hhbrguiOyppznT2wXwHFTvYlgyV24tGilYpkYYyLFuGbunrl7Gppba+00mqIwKILxo80
 FfnuUVBuvwKUe1Zio7HQpDFIKu7x49tqzIp/w55eA9BsH1zU/dXf5HFMUt+IhOLPTNuz
 edOycs96eWeJt6axiDfikbSdC+uHhZl5hxo/bgCutXNO+FD20nFvU+x/5FwZdanfJSa7
 qyxjyfgMAIZAuMM47efAhZh7P7sPcAUxdSnpx+aT8ws/xxB9IVFLeNmpEb69UHa8KgLa
 XL4yZAZccNjKl15U054qdultW6UUSiFH7EVlWRRbEtg9DaVA8gSUFWDZmBUkmApkJw0S 0g== 
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3n3n5qs8js-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 15 Jan 2023 03:57:39 +0000
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
        by NASANPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 30F3vdXI019249
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 15 Jan 2023 03:57:39 GMT
Received: from [10.110.21.213] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Sat, 14 Jan
 2023 19:57:37 -0800
Message-ID: <072de3f4-6bd3-f9ce-024d-e469288fc46a@quicinc.com>
Date:   Sat, 14 Jan 2023 19:57:36 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.1
Content-Language: en-US
To:     David Hildenbrand <david@redhat.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Mike Rapoport <rppt@kernel.org>,
        Oscar Salvador <osalvador@suse.de>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        <mark.rutland@arm.com>, <will@kernel.org>,
        <virtualization@lists.linux-foundation.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-arm-msm@vger.kernel.org>
CC:     "Trilok Soni (QUIC)" <quic_tsoni@quicinc.com>,
        "Sukadev Bhattiprolu (QUIC)" <quic_sukadev@quicinc.com>,
        "Srivatsa Vaddagiri (QUIC)" <quic_svaddagi@quicinc.com>,
        "Patrick Daly (QUIC)" <quic_pdaly@quicinc.com>
From:   Sudarshan Rajagopalan <quic_sudaraja@quicinc.com>
Subject: [RFC] memory pressure detection in VMs using PSI mechanism for
 dynamically inflating/deflating VM memory
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: g3cNJ5ezalwP-36q3I0iwjqzcUmc9j6O
X-Proofpoint-ORIG-GUID: g3cNJ5ezalwP-36q3I0iwjqzcUmc9j6O
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.923,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-15_01,2023-01-13_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 adultscore=0
 mlxscore=0 spamscore=0 lowpriorityscore=0 malwarescore=0 bulkscore=0
 mlxlogscore=606 priorityscore=1501 impostorscore=0 phishscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301150027
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,

We’re from the Linux memory team here at Qualcomm. We are currently 
devising a VM memory resizing feature where we dynamically inflate or 
deflate the Linux VM based on ongoing memory demands in the VM. We 
wanted to propose few details about this userspace daemon in form of RFC 
and wanted to know the upstream’s opinion. Here are few details –

1. This will be a native userspace daemon that will be running only in 
the Linux VM which will use virtio-mem driver that uses memory hotplug 
to add/remove memory. The VM (aka Secondary VM, SVM) will request for 
memory from the host which is Primary VM, PVM via the backend hypervisor 
which takes care of cross-VM communication.

2. This will be guest driver. This daemon will use PSI mechanism to 
monitor memory pressure to keep track of memory demands in the system. 
It will register to few memory pressure events and make an educated 
guess on when demand for memory in system is increasing.

3. Currently, min PSI window size is 500ms, so PSI monitor sampling 
period will be 50ms. In order to get quick response time from PSI, we’ve 
reduced the min window size to 50ms so that as small as 5ms increase in 
memory pressure can be reported to userspace by PSI.

/* PSI trigger definitions */
-#define WINDOW_MIN_US 500000   /* Min window size is 500ms */
+#define WINDOW_MIN_US 50000    /* Min window size is 50ms */

4. Detecting increase in memory demand – when a certain usecase starts 
in VM that does memory allocations, it will stall causing PSI mechanism 
to generate a memory pressure event to userspace. To simply put, when 
pressure increases certain set threshold, it can make educated guess 
that a memory requiring usecase has ran and VM system needs memory to be 
added.

5. Detecting decrease in memory pressure – the reverse part where we 
give back memory to PVM when memory is no longer needed is bit tricky. 
We look for pressure decay and see if PSI averages (avg10, avg60, 
avg300) go down, and along with other memory stats (such as free memory 
etc) we make an educated guess that usecase has ended and memory has 
been free’ed by the usecase, and this memory can be given back to PVM 
when its no longer needed.

6. I’m skimming much on the logic and intelligence but the daemon relies 
on PSI mechanism to know when memory demand is going up and down, and 
communicates with virtio-mem driver for hot-plugging/unplugging memory. 
We also factor in the latency involved with roundtrips between SVM<->PVM 
so we size the memory chuck that needs to be plugged-in accordingly.

7. The whole purpose of daemon using PSI mechanism is to make this si 
guest driven rather than host driven, which currently is the case mostly 
with virtio-mem users. The memory pressure and usage monitoring happens 
inside the SVM and the SVM makes the decisions to request for memory 
from PVM. This avoids any intervention such as admin in PVM to monitor 
and control the knobs. We have also set max limit of how much SVMs can 
grow interms of memory, so that a rouge VM would not abuse this scheme.

This daemon is currently in just Beta stage now and we have basic 
functionality running. We are yet to add more flesh to this scheme to 
make sure any potential risks or security concerns are taken care as well.

We would happy to know your opinions on such a scheme.

Thanks and Regards,
Sudarshan

