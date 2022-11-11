Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFB83625EBE
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 16:51:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234188AbiKKPvH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 10:51:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234103AbiKKPvE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 10:51:04 -0500
Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com [148.163.147.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99AA699;
        Fri, 11 Nov 2022 07:51:01 -0800 (PST)
Received: from pps.filterd (m0134420.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2ABFFPsT021662;
        Fri, 11 Nov 2022 15:50:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pps0720;
 bh=4+8F4iwa0yavyS8CVbCRn4JxKBRqrQOa3+r7fMLRmFY=;
 b=hHv2rnY4iRdyqERY62PXCHQHf4d6CGlWoXhzyULkDz2VdgH2B6zuHI0u7ZGHx/jg0yS9
 aAKZxrKbiF6tQnuLHdIdLNhZ7XG8vOIi/lOxkvX6pBWG2hkON8OIbmZQPhyOmCi0OKlR
 67aU1a8lmxIJlldTlkN6kvVmXhAiXRMIXF3SbqqQcmaJ0GObb2MBqnB9DfmrsU8GccrJ
 vnMRee19MKfZfhnVDhHkWMu9M5C03zt8LTtbRf2BLXgGRxx1Qv4bF5Wj/VmOEG4Ik8nJ
 Y20AUhOeSeKVojIUZZpeaDLfADSU/5GvM5V+RHNwQyRPUCRKCymeOfNJ6WVPjslfHFUQ AA== 
Received: from p1lg14879.it.hpe.com (p1lg14879.it.hpe.com [16.230.97.200])
        by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3ksrv909r0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 11 Nov 2022 15:50:38 +0000
Received: from p1wg14925.americas.hpqcorp.net (unknown [10.119.18.114])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by p1lg14879.it.hpe.com (Postfix) with ESMTPS id 449E9295BC;
        Fri, 11 Nov 2022 15:50:37 +0000 (UTC)
Received: from p1wg14928.americas.hpqcorp.net (10.119.18.116) by
 p1wg14925.americas.hpqcorp.net (10.119.18.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Fri, 11 Nov 2022 03:50:36 -1200
Received: from p1wg14928.americas.hpqcorp.net (10.119.18.116) by
 p1wg14928.americas.hpqcorp.net (10.119.18.116) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Fri, 11 Nov 2022 03:50:36 -1200
Received: from p1wg14919.americas.hpqcorp.net (16.230.19.122) by
 p1wg14928.americas.hpqcorp.net (10.119.18.116) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.15
 via Frontend Transport; Fri, 11 Nov 2022 03:50:36 -1200
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (192.58.206.38)
 by edge.it.hpe.com (16.230.19.122) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Fri, 11 Nov 2022 03:50:36 -1200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q4SeZpAroK+eMEzmW3h7pMBn/MlHbF4eCaVmkDGWFI8SwJwmFNe8br1U2MNNKvRXNacye4VXWVMhQhihIO2nkSG5OkCpzpUzT93RmZq7ZBLDjVfNIgWyFJ/mGCcVh5iqQEkUh24xwK5yObnyRooF2rrnRpZiRtNsfkxQK9c0NM1wIg7ofVMVgpLCez8HhPgHstGTM/AKqoTpmeuWPv3eNLvObV75pm24ZniCW3X1vLEvmMTu79bU6XU8vUi7bsjLI8y1GmrIE/WsI1YcplcQBwkscHqZf5ZWMJ+UXg7TvvtlJO1TdS6JRApJNhN8IpEMr5Y7ZWOf5zzYRciPVeiJhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4+8F4iwa0yavyS8CVbCRn4JxKBRqrQOa3+r7fMLRmFY=;
 b=PSzUpcdIJ5VMp8mo6xAiP+HEzt4DF87YEcAPKmxp+rWYszrmyqdpt/ISIvI9csFdDBbPji89F2PrzrqhG3ExLX4kjMD53noeUPkPjvJDGCEn3D+5QVUWa2jWEpdE11J7y2SsmLofd4k4VJ6Y3GRR0QgvGOEqKnK/cUIxgG7/ZaAea/oqJyIWpkG6POZcFWsjg7HrL0eAzvuu7ikJe1sdNoDkDaO+6p1bD2LmBNWz2vYb0om9/v4ls4RBcCsgwtxW5phfqfaENzSTX5BIWrsRwveNANFncSPfFccnGCMUBLMOxvCHjD4Hz+Z/EoYLozz0CyRKplgujbVQfoq18TU83Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hpe.com; dmarc=pass action=none header.from=hpe.com; dkim=pass
 header.d=hpe.com; arc=none
Received: from MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:303:1c4::18)
 by PH0PR84MB1357.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:510:16f::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.27; Fri, 11 Nov
 2022 15:50:35 +0000
Received: from MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::e739:d90:9fca:8e22]) by MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::e739:d90:9fca:8e22%9]) with mapi id 15.20.5813.014; Fri, 11 Nov 2022
 15:50:35 +0000
From:   "Elliott, Robert (Servers)" <elliott@hpe.com>
To:     Zhen Lei <thunder.leizhen@huawei.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        "Neeraj Upadhyay" <quic_neeraju@quicinc.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        "rcu@vger.kernel.org" <rcu@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2] rcu: Dump memory object info if callback function is
 invalid
Thread-Topic: [PATCH v2] rcu: Dump memory object info if callback function is
 invalid
Thread-Index: AQHY9bjXD1e3c0hMYEKiHo9i156+S6453hBA
Date:   Fri, 11 Nov 2022 15:50:34 +0000
Message-ID: <MW5PR84MB1842F925447B4BD175CF23C9AB009@MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM>
References: <20221111102822.224-1-thunder.leizhen@huawei.com>
In-Reply-To: <20221111102822.224-1-thunder.leizhen@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW5PR84MB1842:EE_|PH0PR84MB1357:EE_
x-ms-office365-filtering-correlation-id: 158bc376-a6d8-4a4e-d4fb-08dac3fc78a5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: UBXDD+chE7OUZlaJvx+ZuKESy/Lw7UHA0LpvShLy4+yNUOZky+0S+7MTS7JLLFTUAvIcEF+z4R7YzvB25vE4Hl5dHAZ2a7v8SEZrWuB6krGxAqJfzj6qkmXQvQVieNM5ncqRkgftbQjSt1PSpH3lRycJfBijjfZtHa4kB4FZ5wk6n+2HWIq+kZ/GrAqiIfxsvRV/xKPrtOM0J+/rmS5m2pCehjLOw4n8I4OH1I2mUaE/tCcEx+sv7WmaL6L9Wyvg+I3Zb8meKePze7tfMmqa7crTmM4C4BIAfKwdTpHQbxFfx/Wixvmsk3pEu0tNZs6D9I+d/frYOyAtlozmi6+U3Ys2yuygO0xyqSNMfY3KbUBTxHpnUFMbqcGlse1mPkjNXyNo0PpxVi2Pdn3XB86xSr9bx51OXr+Ka7g65fXsPrqCg+VGSP38mYUaCgU60+AFdtmR/gYQstyFJ9HG/27IHHzOEfE9SwvKjvCD+Rya8bejySSpIM5tnISFWTUDTU6FvUGV5N4WoOjWLmJdAD5WAgUgJlFIMB1XbV+z4SUvGUnS994fdFjt0OkJFUQbbH9YIBKNbOxvAy42xQL18KNvgRV0pV3+ZsTNDXIbnkZ0puG0futFhXaicp/L3VyKA9/R3TIjFd4XlskwoDX1G1gYdp1njtk7w1nHTW564X7RZ7osK1Ed8s/xraRH1K6pmdRCoQyCbHiB9Bdv01rta5brxpgY/n6poKQsL7I7W/W+A3RMvxH0DiMC1byFOQuPLg74GS2jb5d3d8jRwtfeQh2LtJn1RsblEqN93dVQJxyuO3c=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(136003)(346002)(396003)(366004)(39860400002)(376002)(451199015)(38070700005)(122000001)(82960400001)(71200400001)(38100700002)(478600001)(86362001)(66446008)(83380400001)(921005)(66946007)(186003)(7416002)(4744005)(64756008)(66476007)(8676002)(8936002)(76116006)(66556008)(6506007)(7696005)(5660300002)(33656002)(110136005)(26005)(52536014)(316002)(2906002)(55016003)(41300700001)(9686003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?lxAkz7HvnTxL4rOsho7CT46R4A+SqTXtI52oCtyn4+0446i9k0EJ++wI/XdU?=
 =?us-ascii?Q?nvUSIvv3sE2w4Blu+KMbMZN46tFyTw2iuhonmUkEFQsD3l195WMmNRf+Qpwn?=
 =?us-ascii?Q?EgE+cVnRTCOJFIhj6zsT7vfRMpUTjDssAj1FYhkW/ff98drG2JagOApdxoZw?=
 =?us-ascii?Q?33WpVtORMPNDEdpkHFP9MqltA2hKpae7pXxA7vn2QqN32W38wPadGHGTsdiu?=
 =?us-ascii?Q?mD7XewVg2BQl3mX+uSUmEk2PF/ReH9Bl58MkaRr9FnYkPimGzXEuVnAsD9Pl?=
 =?us-ascii?Q?KE2KVj/bn9aZgaDxI20xLmfCydBVpwz4HwYbyzBT4DQaT2cIeAEBjt+kUqPX?=
 =?us-ascii?Q?VeJpMKJ/MCwF21FwQcewzt3/9xA/iT1z4p/wQiAIjcm/cstRWw7WkQM40xsv?=
 =?us-ascii?Q?LA3v2+/As9F/nt7/W0vUDqFvCnGt6pLewjlh0M4oB19Fz2ojPsFygVnx5LjX?=
 =?us-ascii?Q?N25zA8Ey6YaCrjzIh/MZeNby9FDhxvIhqRxtv3mln6zHqHlHi5WekUW/Tj4f?=
 =?us-ascii?Q?4ImEasfvaJjlEcrqTt5H2fDEk68c9fpVWYHIcW+LEkGdSMA9VQJhi6dsg8do?=
 =?us-ascii?Q?7DylJXGC25CF3DwqaiPaed4g9dLhPmR7ziH+/GfEbMT/OoDli6yW1o89hKBQ?=
 =?us-ascii?Q?jHCiZY73f9MBL7ZNZPco23H3YOBHdsZ1SeoFysGmJ7qZCIuy3YeNh/VUz7/l?=
 =?us-ascii?Q?1T+CK21ga+3e3+1+les2gdA5IiVlC6a9axQ41FPAsQc0MmSy7EX5+BlCpvop?=
 =?us-ascii?Q?lk6yycgOeS+PjDyCB5VyIP5QiksWLQedVtRiR+op0wkMQURvmC9dF/KgBRHG?=
 =?us-ascii?Q?8O2RFJOot8GylA0BxqOyDiZJur/4LmoG7k9RiqmPzCYovZN+TkcCBZC6zo3S?=
 =?us-ascii?Q?VBC7CGijHmzlcjO986vYg+BF6HmjreFnlK/ftW6uqQ+MJvgCCe7MHrScrbce?=
 =?us-ascii?Q?vRTw5qzeHXFbchkdFQx0iHNnYY1tFIxwSjHwClYuTDTPSAqAgCvcT0GYrNYE?=
 =?us-ascii?Q?64TnoGPqh13cf89b80zZ2qconymmpAMQ3HdX9TEI2f9sygOVQnMPA03EPkkC?=
 =?us-ascii?Q?sQyOHrSTEOzMRhLmFK3q7+5lpB97LtgPoRUiEi0b/77aWJ49P7pT5ePpwqc/?=
 =?us-ascii?Q?AbqcswzT4m7soWNcLl9hR9eBNz3StrlFB6/1j844Le23Kaqy0zs8h1t37Baq?=
 =?us-ascii?Q?WjrJy7yoogtpTg/hnZHEe1Gi+RksZJtDyLiY9IIcRbAyiKxah+2V9gykYAkw?=
 =?us-ascii?Q?TjdcvLmIm5DwsZFe4ni12UvSKJ78mpojmKkY/sjJ1VhMwRhqollJv+VaZQT2?=
 =?us-ascii?Q?ZF9PSO3BAHMsXhk6nDhzq+jR26w3OHylju7chN5aNUS7JjiKkBt0+hGHbjMa?=
 =?us-ascii?Q?sVGFeqrMbLsJ0RGR1XCxNqSOPz46qXsv0/1kD/4iWZd4Hhl+60jhtqrnCQQM?=
 =?us-ascii?Q?7oCUGE3AvlDPb/IH/D75hpzEJt5YUzRrPCSJmpqXf7+62ZeI3hL/iG6Dfbd7?=
 =?us-ascii?Q?dqEqIT//q2vmU4rK7RIZF9tmj/gg0PeuF4mSq9LWV9/ZOXzRy8jfMuGT3QmJ?=
 =?us-ascii?Q?wc8809y2zN2h6Zjqics=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 158bc376-a6d8-4a4e-d4fb-08dac3fc78a5
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Nov 2022 15:50:34.9342
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WAyKYcGtFHjS0XNVvMMDa/SCfjRub+0znK8QK2O3akyBgGKsHWYw7bsqOTdKD7HZ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR84MB1357
X-OriginatorOrg: hpe.com
X-Proofpoint-ORIG-GUID: NKUUmKikswbXlIthkjlDzzMtt1M60KuH
X-Proofpoint-GUID: NKUUmKikswbXlIthkjlDzzMtt1M60KuH
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-11_08,2022-11-11_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 suspectscore=0 clxscore=1015 mlxscore=0 impostorscore=0 phishscore=0
 bulkscore=0 priorityscore=1501 mlxlogscore=999 spamscore=0 adultscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211110105
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> +static inline void debug_rcu_head_callback(struct rcu_head *rhp)
> +{
> +	if (unlikely(!rhp->func))
> +		mem_dump_obj(rhp);
> +}
> +

The mm/util.c definition of mem_dump_object() says:
 * This function uses pr_cont(), so that the caller is expected to have
 * printed out whatever preamble is appropriate.

so this needs to call pr_alert() or pr_err() before that to explain what
is being printed (with no \n), like these:

kernel/rcu/rcutorture.c: pr_alert("mem_dump_obj(%px):", &rhp);
kernel/rcu/rcutorture.c: mem_dump_obj(&rhp);
...
kernel/rcu/tree.c: pr_err("%s(): Double-freed CB %p->%pS()!!!  ", __func__,=
 head, head->func);
kernel/rcu/tree.c: mem_dump_obj(head);


