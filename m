Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0929974D169
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 11:28:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231410AbjGJJ2Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 05:28:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232072AbjGJJ1v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 05:27:51 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3ED6AFE;
        Mon, 10 Jul 2023 02:27:48 -0700 (PDT)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36A9HpX1025086;
        Mon, 10 Jul 2023 09:27:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=rDDZtmypGPN4A6hdBTIzFD4WFJjliNYyRWC5mwV6BxA=;
 b=qXn8UC003w/hqSbrzEigZXWHC4QaIXVA16aFDghGXLt7or+6PyuUlXazDs1m2ChPTps9
 0/41jtB5YZzLbHrLINox74tzJj8TlONpo3vl+aHQSgVUnBEWJUB5WoX4pg3NnIlNUVyb
 zPMYWYTRPI+UP/dTVMguncHH8cdU+1DPNS4wmMd2V8Mu4CP/3ABJnou0FZbWr0wdgJoA
 ZmAMkFa8laZbIiD/nTKuWDAuDU3GQDoygkbsJsJAI2yGuKSJRB8Kb+WH/yAX2n4TlSW0
 q5gMmhi1uddKEsrCAyeBbEQQxyhONNfa9WdSD6ivWqIq0ohn6WOAAKDil3pNQsuN8RVt uA== 
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rrf7r06xy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 10 Jul 2023 09:27:41 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 36A2lQZd025773;
        Mon, 10 Jul 2023 09:27:39 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
        by ppma06ams.nl.ibm.com (PPS) with ESMTPS id 3rpy2e158y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 10 Jul 2023 09:27:38 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
        by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 36A9RZur19202590
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 10 Jul 2023 09:27:35 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7404720043;
        Mon, 10 Jul 2023 09:27:35 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 782BC20040;
        Mon, 10 Jul 2023 09:27:33 +0000 (GMT)
Received: from li-e8dccbcc-2adc-11b2-a85c-bc1f33b9b810.ibm.com.com (unknown [9.43.85.154])
        by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Mon, 10 Jul 2023 09:27:33 +0000 (GMT)
From:   Kajol Jain <kjain@linux.ibm.com>
To:     mpe@ellerman.id.au
Cc:     linuxppc-dev@lists.ozlabs.org, maddy@linux.ibm.com,
        atrajeev@linux.vnet.ibm.com, disgoel@linux.ibm.com,
        kjain@linux.ibm.com, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 00/10] Add sysfs interface files to hv_gpci device to expose system information
Date:   Mon, 10 Jul 2023 14:57:07 +0530
Message-Id: <20230710092717.55317-1-kjain@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: YLSQjVPeIWUg3xjZ_xZ-DD6XA3rV8ZxK
X-Proofpoint-ORIG-GUID: YLSQjVPeIWUg3xjZ_xZ-DD6XA3rV8ZxK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-10_07,2023-07-06_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011
 lowpriorityscore=0 phishscore=0 spamscore=0 malwarescore=0 bulkscore=0
 adultscore=0 impostorscore=0 priorityscore=1501 mlxlogscore=999
 suspectscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2307100082
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The hcall H_GET_PERF_COUNTER_INFO can be used to get data related to
chips, dimms and system topology, by passing different counter request
values.
Patchset adds sysfs files to "/sys/devices/hv_gpci/interface/"
of hv_gpci pmu driver, which will expose system topology information
using H_GET_PERF_COUNTER_INFO hcall. The added sysfs files are
available for power10 and above platforms and needs root access
to read the data.

Patches 1,3,5,7,9 adds sysfs interface files to the hv_gpci
pmu driver, to get system topology information.

List of added sysfs files:
-> processor_bus_topology (Counter request value : 0xD0)
-> processor_config (Counter request value : 0x90)
-> affinity_domain_via_virtual_processor (Counter request value : 0xA0)
-> affinity_domain_via_domain (Counter request value : 0xB0)
-> affinity_domain_via_partition (Counter request value : 0xB1)

Patches 2,4,6,8,10 adds details of the newly added hv_gpci
interface files listed above in the ABI documentation.

Patches 2,4,6,8,10 adds details of the newly added hv_gpci
interface files listed above in the ABI documentation.

Changelog:
v1 -> v2
-> Incase the HCALL fails with errors that can be resolve during runtime,
   then only add sysinfo interface attributes to the interface_attrs
   attribute array. Even if one of the counter request value HCALL fails,
   don't add any sysinfo attribute to the interface_attrs attribute array.
   Add the code changes to make sure sysinfo interface added only when all
   the requirements met as suggested by Michael Ellerman.
-> Make changes in documentation, adds detail of errors type
   which can be resolved at runtime as suggested by Michael Ellerman.
-> Add new enum and sysinfo_counter_request array to get required
   counter request value in hv-gpci.c file.
-> Move the macros for interface attribute array index to hv-gpci.c, as
   these macros currently only used in hv-gpci.c file

Kajol Jain (10):
  powerpc/hv_gpci: Add sysfs file inside hv_gpci device to show
    processor bus topology information
  docs: ABI: sysfs-bus-event_source-devices-hv_gpci: Document
    processor_bus_topology sysfs interface file
  powerpc/hv_gpci: Add sysfs file inside hv_gpci device to show
    processor config information
  docs: ABI: sysfs-bus-event_source-devices-hv_gpci: Document
    processor_config sysfs interface file
  powerpc/hv_gpci: Add sysfs file inside hv_gpci device to show affinity
    domain via virtual processor information
  docs: ABI: sysfs-bus-event_source-devices-hv_gpci: Document
    affinity_domain_via_virtual_processor sysfs interface file
  powerpc/hv_gpci: Add sysfs file inside hv_gpci device to show affinity
    domain via domain information
  docs: ABI: sysfs-bus-event_source-devices-hv_gpci: Document
    affinity_domain_via_domain sysfs interface file
  powerpc/hv_gpci: Add sysfs file inside hv_gpci device to show affinity
    domain via partition information
  docs: ABI: sysfs-bus-event_source-devices-hv_gpci: Document
    affinity_domain_via_partition sysfs interface file

 .../sysfs-bus-event_source-devices-hv_gpci    | 160 +++++
 arch/powerpc/perf/hv-gpci.c                   | 640 +++++++++++++++++-
 2 files changed, 798 insertions(+), 2 deletions(-)

-- 
2.31.1

