Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D0DC69595E
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 07:45:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230370AbjBNGph (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 01:45:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229648AbjBNGpf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 01:45:35 -0500
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2134.outbound.protection.outlook.com [40.107.243.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B278EC65
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 22:45:34 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=awsmKRTzlUnIxqO1V1fJS+ZvprgDuRQdjA+N0SZle7XjGwiwqcsF5gAbRPWjKDKD/Y86wpr45RhCqd6zNtKQ44e3vsGSqh3jzAxRPelw1f/S/ry1TZkBOhh8QDUPXNhAWgbM3LRAdl3L5TjXMjmzZ8TxQ4zqD4GDogWVNoiAIFwbsaCEzgFxFj65Qn4H7gKlFLzZNgq8SfOwcJcspeHB+VyJJh9MdIdVihpe1tTQ6bmIyj/gVSmCfdRQ+oUWC6yTfzF5EiijeQydiqM4vXp+RRMN5BrxL8/iXjCxVWJlcltEfQ7Hy9he6PTw4R6f1l0FA7dYked7Whljl1jH7WENKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2U9zQJodKFakKoVMXhwHhO9xtRO1i99EnZ1HnelRXxQ=;
 b=HHFQOi2Oe/ZV8xSvp6jGl3tEeQSDQ0+JDMHmaetLalFNCaMx7cMWXPC96KNGnKC62JLREx5CZ5QlW1nuL8IEHWeUDa8vqUkWmmA15jovpk8flfIrjOJGf8XXUJXZNJvQjVbLMW9FI/LfraJDvw0v1r100u2MJiwL0u3j7onIFj6Evthe28rauBA4VyPiIsBPP+GlXBSyYkoCkD5gzxWPk0dSuhNaOvVoNdwn3UeVmdQLpl4mUlyK0ZX+KQsNKbWq9usuTOLVb0FHVI+3w8SZNbBR2GQCoArlFDhC/Su3U4ZXSZexjEVS4OMAzm0+uezm8RFbMMHItNbo1RRd2Qot1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2U9zQJodKFakKoVMXhwHhO9xtRO1i99EnZ1HnelRXxQ=;
 b=BZbvDtvN7SmgEOnFanzdrycQ5IVWAVK4TGte9u7siOCXdzHSkXlcsqb1xq2YD6qQ+AsCodFvSI0KkqaxgXgZ9/O3QM46FSTbTTPTEhzW/0bfdAE5nI9PgAp2s4nISB28ckbtJsyihaBaBSxbZmgckk76/LxFvrVmRSlPEDcyaj0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from SN4PR01MB7455.prod.exchangelabs.com (2603:10b6:806:202::11) by
 DM6PR01MB3962.prod.exchangelabs.com (2603:10b6:5:84::11) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6086.21; Tue, 14 Feb 2023 06:45:31 +0000
Received: from SN4PR01MB7455.prod.exchangelabs.com
 ([fe80::bf6:8038:9fe8:1588]) by SN4PR01MB7455.prod.exchangelabs.com
 ([fe80::bf6:8038:9fe8:1588%4]) with mapi id 15.20.6086.023; Tue, 14 Feb 2023
 06:45:31 +0000
From:   Quan Nguyen <quan@os.amperecomputing.com>
To:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>, linux-kernel@vger.kernel.org,
        openbmc@lists.ozlabs.org,
        Open Source Submission <patches@amperecomputing.com>
Cc:     Phong Vo <phong@os.amperecomputing.com>,
        Thang Nguyen <thang@os.amperecomputing.com>,
        Quan Nguyen <quan@os.amperecomputing.com>
Subject: [PATCH 0/2] Add DIMM 2x refresh event and failure syndrome
Date:   Tue, 14 Feb 2023 13:45:07 +0700
Message-Id: <20230214064509.3622044-1-quan@os.amperecomputing.com>
X-Mailer: git-send-email 2.35.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0023.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::17) To SN4PR01MB7455.prod.exchangelabs.com
 (2603:10b6:806:202::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN4PR01MB7455:EE_|DM6PR01MB3962:EE_
X-MS-Office365-Filtering-Correlation-Id: 01881be5-cc10-4814-9171-08db0e5710d0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: l/zm/rM1zLr19KmQYEXfwk2JZVGufjGV/SHHt6XC+/Hah92L1STu912Kbh1w6PfmKno/8Fxbm+Gtze8MczS4gHo519AgI2x+ojgRxd7rMeIfhMJ9ika+glmM+qoaNh0G/0lsNd+iEHuqLXt7cuIW2vUBHJESklKgnYD2LdYbxS4HO+FE3u4rSqzqcfTLUZoeId0AXoRvbwVSvFIJficRX2lzDbFuepYXKGFjqZDz1SsVSRXQQq2ytloYrwi+5+rPNBJeu/KEjFd7RHUzX321MErs1/IOeW1j3RlavwTjZkxjlBo2bfGSt1TJdzVbtiCFcEFWuLzgi1/z/GY+gZiETXQlTorMlYX8xeKu8VTkceIk5YuyD/se7/JYnX8CHMqGffBzesQsFHGVPsN737flLcKyfzRi1M869K+Q3QIZqnrgg5bziivSzA8u8tZsBOjtkg7ylwB6MwNVftEhFqMg0xmkpEhEdkyVxUq0MMVU5WeWA/vfuTzN4ZMhL9WsJxplcSQkSdQxrVcDZQhgDsdH2LQQczCRuYR771ULkbg+KUjSZFYda3Gop0RvPrwZU0QHp7mCb1rWsfvPcoA/keO881HT4RDhr/rWBOuNrmuPEAg+SGOnMzrHUU7P2ZawfFtBu14wOCJvrVEXlEAuW7E5YWxrmAUzLrKUPhautHjisWUZmmi3YaToSjZbbPK9OEKSry6f46zSWC0rpTPDWxQIrQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR01MB7455.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(366004)(346002)(376002)(136003)(396003)(39850400004)(451199018)(8936002)(5660300002)(316002)(2906002)(110136005)(41300700001)(4744005)(2616005)(66476007)(66556008)(4326008)(54906003)(66946007)(8676002)(38100700002)(38350700002)(1076003)(6506007)(6512007)(86362001)(6666004)(52116002)(107886003)(186003)(478600001)(6486002)(26005)(83380400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?tJ3TnQs69B9fi2xJVsxTujOdcwclzqBYS7lFU0NZWX5cZjB2vJ2o7Zp/q+/F?=
 =?us-ascii?Q?mcpkk1VSHazfZLe3WAwUOJdfd7ergIvzoLIZPCskdEpiBafF5haNZzJ6NcGt?=
 =?us-ascii?Q?SLBiRGZQFIq+UWfWDOQMve0Msd0FEX9M5pCM96Q+I2GnnIyoiJIR2qBiTTKF?=
 =?us-ascii?Q?vcXra1cllQ8y0OPnc6bGHZbw02nw18OXjh3f2QY9LMmRlGgRzzsZSAHUqqhc?=
 =?us-ascii?Q?HxGmezMM6QqXS0/VOfGUCy0g2I6XVoyZlXsWp5CRXetp/8gCOHQt84A297+r?=
 =?us-ascii?Q?YgKLCR4rT0kOeOpR7GctfzWqcjBXyZPHLEV6MnnD3JkBGaQ0WpNO0NuTucAm?=
 =?us-ascii?Q?oe/EsAz52sBiRwygzRoHcciLouKNPJjjeG76ZuI74+UpqHb/W0Tq3NjDjwT5?=
 =?us-ascii?Q?vTg2UqalFlHREC4IjB+mixW/rHOt+H9NVuP4Ram8EmdqulpE5/5OghA7Bbi+?=
 =?us-ascii?Q?bcTnsXK6ibWAFLjTnpbzyltFn1ThUyRYA3o8f5UUph0nieWRPOKEBDHfibia?=
 =?us-ascii?Q?G/ZgeMXe6PaDPMhclzwLMADVA8Re+xqIL70yMdMA8JmRbgrlKtp3e4f7yGBe?=
 =?us-ascii?Q?QdgEQ6uCRqwRg637i2/HbDE7pi7vJ85/GULoYUhs4MZCjVfmM+zrJiaP1o3f?=
 =?us-ascii?Q?rwsQ0raLRkrRmUlC/uuBrfAgB4Z8AkfAUY4s76xdtOmBBY2c/Q2pzpBX0IcD?=
 =?us-ascii?Q?LXrywWavgakodXzMuQeu+kF4lRgL81uKKexOc+CgJYdvS+ym35dmpb5YC+bd?=
 =?us-ascii?Q?67s2sTx7eSi/ZNwc6StZhx/yJgvw+bx/UkCM72A/i9bM6P62fGxmkgkVCpwy?=
 =?us-ascii?Q?fai3Aye9/jEru+/4ERiRXYB0Zleajuiw8vHnccUN14us8KNI6lfjqP6T/LBI?=
 =?us-ascii?Q?6WTGwssKYFCNesF2KTHn7NkCk0ch6TZjwMQ20JshcMCZsuvzG2BBC8lsdz6k?=
 =?us-ascii?Q?wmCeR1Amfsj00n/hPo8WJHd+hBafePk3kT8HKTwVvf7ucuz+KzWdsAR7Jpe9?=
 =?us-ascii?Q?UPnPrweRjRq2Wdss64YOT2LGmSFmv/eOQxmUSNlMb6Gb5Jm07zMNjD5ZZiTH?=
 =?us-ascii?Q?MroqHvR1XI3lntQ5Nv28gNWSUQ4nsPvVamI4MXN+lipgYb0TpMELJUnFMuo5?=
 =?us-ascii?Q?nDuRRuKMtabzNvpnXa8uk8CXJmnV/catozwLuWhg7aWHf30KfXTHZTe6sWU5?=
 =?us-ascii?Q?K24yzi3ura0DY9nKx0x8BUOlGpJ/9cxk+2jBxwmHoX3CQeMcixjYvf7nq3UY?=
 =?us-ascii?Q?AYfAB4HOQECtn92xKzRU+ZTHlJXKhrkWHYw2Fd6wdbiWMBWNqj8ynK3LiNkl?=
 =?us-ascii?Q?ewHy3QqVvcwIa8CdQNeqAla4FRNQFjsxlnAuB+kz1YNWHzVLi+2/0IOUTZL1?=
 =?us-ascii?Q?fP92G+JoqsFod+JfWieales/he9q9zmnkRF9nWLCukT+KCDdB/uQg0yCtuTM?=
 =?us-ascii?Q?/zraocVdeD9lNkUYgG3NVKzGN3opH+YwaJlVrbFAyisYJpXzK7Db6Q4U21Ov?=
 =?us-ascii?Q?EqKVnw5YnZ0Hwx0IiSqnGQTAlJy/B6sgyzFtmFoycmUSvSslqSOETBgeU2/c?=
 =?us-ascii?Q?L9B/M7lc4pcc+rgNLEdqBpuMhSIRFJbbHr4Nl5Er/Mq9gHDebNMQ38II7Ztc?=
 =?us-ascii?Q?Ws0JQEmnKV2DMkwx1xQgJCc=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 01881be5-cc10-4814-9171-08db0e5710d0
X-MS-Exchange-CrossTenant-AuthSource: SN4PR01MB7455.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2023 06:45:31.4479
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vX3A0PoDb1LAs51ec9e7w6MUxLvFJorGb9pZ3wJjMqJHVOexl4BoLr9S/rUGKm2bV5M7qjBFF4qO60EujFYsB/7TPYrpOm6CRA466+kGQNo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR01MB3962
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adds event_dimm_2x_refresh sysfs to report doubling of DIMM refresh
rate on high temperature condition and event_dimm[0-15]_syndrome sysfs
to report the DDR failure syndrome to BMC when DIMM training failed.

Quan Nguyen (2):
  misc: smpro-errmon: Add DIMM 2x Refresh rate event
  misc: smpro-errmon: Add dimm training failure syndrome

 .../sysfs-bus-platform-devices-ampere-smpro   | 15 +++-
 drivers/misc/smpro-errmon.c                   | 82 +++++++++++++++++++
 2 files changed, 96 insertions(+), 1 deletion(-)

-- 
2.35.1

