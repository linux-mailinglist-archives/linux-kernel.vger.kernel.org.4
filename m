Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72CAC6E6FA3
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 00:48:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232842AbjDRWsN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 18:48:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230053AbjDRWsL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 18:48:11 -0400
Received: from mx0a-00010702.pphosted.com (mx0a-00010702.pphosted.com [148.163.156.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D68AD3C39;
        Tue, 18 Apr 2023 15:48:09 -0700 (PDT)
Received: from pps.filterd (m0239462.ppops.net [127.0.0.1])
        by mx0b-00010702.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33IIkpQk011018;
        Tue, 18 Apr 2023 17:47:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ni.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : content-transfer-encoding
 : content-type : mime-version; s=PPS11062020;
 bh=IyJX8sNX7t+CUJg1q4Ll48MlA9YYaov8hFrNbc/8mVY=;
 b=v6C9BKqzB/QNHHtvZ2CRd5dwtc39h+2iA4CkPm/sqeUYx5OajYtDFZwrnx+JGngyGNhx
 pcNnvHH020h7HUiRPLGVxMHThJQtpTMpMHTldz9HW8xN7yQtuQORvDE5sfOAiGxLrsxa
 SONrITxQKc2JX8yi5OJn+AgK8hdVZRv737UB6dDJgB532fsWbCx+blDmUrMjyKfcNQcU
 B+XOAmGYtcP3qmgjS5c+5ZTqOAm0aFEI2DERfqcrnMgzKHdph9qHnum1NyMfTUBM2NCc
 r2i1Nxz3yEllHZN/ZPPh/KRX6kIECpv8/KrOVeojS3H9l0koBYVCWEGWcEpm4HPgIZPt /g== 
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2172.outbound.protection.outlook.com [104.47.57.172])
        by mx0b-00010702.pphosted.com (PPS) with ESMTPS id 3pyr0eq17h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 18 Apr 2023 17:47:54 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ikd6vMQP6/xREJJjSimPa9vS/RDZywGnHTGtRFF3mNbGtoIciRQRmoxrGTS5jd4vCWWaHfljv2R+V6IGQSfwXDJYidwJ4eFnONWrwTR2viZUmIQXLfuvj6QmlR8VVXqbQslHBj4mLSRTjV7VIXmoOJKt3ubgIQgkyIT0BRCfTdnz0brEoRQFP3Oaj87gdB63PzmNOPj+g5XwzITstvC8eAkcnMcoCXPweLRrbpNHryK6nH3DSEDMaIZpxz/fx/HaKziUfGXHB6ET7WTWqj9hHpi25YFeHzF6tfXE2zZfzcWdqaGJg5/zAG8Onk3AmdfyHBhtWhA4Ps0CxJSn3Kbj7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IyJX8sNX7t+CUJg1q4Ll48MlA9YYaov8hFrNbc/8mVY=;
 b=L8Cx6UanID055E3yZKDOLjyncW77M2Dx9Et6cnKkarz5I6qSZ+gpoXZtxfMn4WWgiV3IDSiLIovhTjuVIR0/oEHDgngsoRsJP2bnMtnuTjWmSaa3ROE4wdoAcalD2LbMIchVGYOFqf2nr3HQQIXqVQFZ8Dbb3cT6kOoINCuZ6H2CFfrxKfd0ZYKmQ9zr9qffzVIjtsBz7Itho1cgel/Wx0kBEasMwBerzHnT8qQpW575UhQj9i94Ml79mqWGk7rVP42QcBx6ok4SdBw8oK7A8Taa7DRqnwkfWIwnthCG/lsb8SkNIfJ3j9ISNrEcXIhpUnYnrVoXZgW0U3hAl2Tvkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ni.com; dmarc=pass action=none header.from=ni.com; dkim=pass
 header.d=ni.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=nio365.onmicrosoft.com; s=selector2-nio365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IyJX8sNX7t+CUJg1q4Ll48MlA9YYaov8hFrNbc/8mVY=;
 b=Ge1xA+/b3mUx9eNkE2Uoueix4pU8h4YSRUxr2AN+HNR5cgcLfzSHLtQautTSP4bdr0haMUtTMp9amf0X1ZrapxxPLywBpKwhSHSFVkDL7xUpgAGgkrGJrhmaHHlUjbzEsok89+zS5YvyiFjxfpDKMSVZUZ77ahPch3FkMwehNtw=
Received: from SN6PR04MB4973.namprd04.prod.outlook.com (2603:10b6:805:91::30)
 by DM6PR04MB6761.namprd04.prod.outlook.com (2603:10b6:5:243::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.45; Tue, 18 Apr
 2023 22:47:51 +0000
Received: from SN6PR04MB4973.namprd04.prod.outlook.com
 ([fe80::f4d5:a7d3:adac:3654]) by SN6PR04MB4973.namprd04.prod.outlook.com
 ([fe80::f4d5:a7d3:adac:3654%5]) with mapi id 15.20.6319.020; Tue, 18 Apr 2023
 22:47:51 +0000
From:   Brenda Streiff <brenda.streiff@ni.com>
Cc:     ilpo.jarvinen@linux.intel.com,
        Brenda Streiff <brenda.streiff@ni.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 tty-next 0/2] serial: Add driver for National Instruments UARTs
Date:   Tue, 18 Apr 2023 17:37:58 -0500
Message-Id: <20230418223800.284601-1-brenda.streiff@ni.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230410211152.94332-1-brenda.streiff@ni.com>
References: <20230410211152.94332-1-brenda.streiff@ni.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SN6PR16CA0052.namprd16.prod.outlook.com
 (2603:10b6:805:ca::29) To SN6PR04MB4973.namprd04.prod.outlook.com
 (2603:10b6:805:91::30)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR04MB4973:EE_|DM6PR04MB6761:EE_
X-MS-Office365-Filtering-Correlation-Id: 1fa02e56-2581-4720-ab85-08db405eefc7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jCwf+XOGN1ZvGhv1pcxdjKAzoYxt76w9JnOx9B9OcM6aqw4UD8nQTeFYn2trvT0xmLjDXWRyaFAjl/4A2HC/QpZS6idgyX6lfEPfYtbuNm/sDJjzVB+BX2RTjInZQz6GXQoRE9QkdbSCwifeMzbMDICSfjJZ9U+ZSf6h47NKdpw6+ro9sXZm94O72hvGjlr627yXkZZUYSiE0FFRK0tg5Pj+2STHBnSLa2YFbf9ufmAXutdfOkj5w6mbkQeyIeN4z0LHEdeDW27GClG2jupTydayZH17yl4h2J/6THOZ0ZQ/i6+QMPnEyTqYeOfXIL8kjnupQ+xfEN4Q+WFjAEQxyEXV+U43bVAAxfeqzPo8jHz+x6HH0GxRtYJpwIs6hKA+fS9wZdM/Xoe2OtI3nES3QejqKGyKTYtVRGRVB4GdYUeERcyo7UmNfPOPdpckJe+OEfo6QmuvmpAGfPE8qYe3g78qhOFtv29BRO90ABsxWPBnIWwqmUn9ZpYfytKqdPPvzbBheQdltuTLJFKCNseSMHw0R1Cr0iWjTAqO+wblDYPTiOVklao7e7CJiR5rh3u9wd0G0O5r0jMCzH5zdd5dUk57uBDGqXrsf4qiwlr5oLE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR04MB4973.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(346002)(136003)(366004)(396003)(376002)(109986019)(451199021)(44832011)(36756003)(2906002)(5660300002)(8936002)(8676002)(41300700001)(86362001)(38100700002)(478600001)(2616005)(26005)(1076003)(6506007)(6512007)(54906003)(186003)(6486002)(4326008)(66476007)(66556008)(66946007)(83380400001)(316002)(266003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?bEzhp2JNlXnziqcAfan7C07IQAJ18ping20Fkwfj5XRgf3gc+698QO6/SBSd?=
 =?us-ascii?Q?cN7GtVRqn+0WwpfNwRCaamqJ3SIk2E2MrUHGKtSiaYI82wkuOAPR7QoVE09D?=
 =?us-ascii?Q?O8dwkbs+vqJ9jEf36qGTIo2SwdV47xGtbgAQRyZeCoKVa5UMug/Z1/dtQ5oe?=
 =?us-ascii?Q?RAv0b4/fdvgeskqwKMvfhPmKtF1ionqISFJl6HOp7+4U2xhpWAJGEzC0YZFT?=
 =?us-ascii?Q?SRBp9/JEKoAlB47/Ffi4lbjMbM53zzgR0B3vXY4sdB9KC5wgg4vfXRrLeBxC?=
 =?us-ascii?Q?Is55V1UgZ7pro659qgyv0mp9Ade1VDqNO7EFSdFJmGH0PDQJvrJ4zQtQiEW1?=
 =?us-ascii?Q?aQrkKK+wOOokVTjQ2Cyo7P4GoJeDwKZRjnwoko8tNvaRzHC3LxvyJ5LzIzQ4?=
 =?us-ascii?Q?pOAN+i1k43s/BVHCogKX1/Nd3inTpICOdXqaTFG/a7BcQOOZ5AYlBLqUY/3r?=
 =?us-ascii?Q?FNjH4LJQEJiFlpB8m4xYi/eZFKEIpCTdH5wOFazxWm0zt95kRVaQ92SVR5gO?=
 =?us-ascii?Q?6l4s7EijQ6w1jjJCCWhjvlqI5T/aYUWaKHVfOvT+qhHwx27DTnlO6J5PmEFg?=
 =?us-ascii?Q?mvsw00HmAz8kkBPls6GUSirfvFYysb9yxGE6caWTPFMlxH0h1V1EMEG6kJAK?=
 =?us-ascii?Q?KN0IgBQ/6KcizKv7h27JOZdeMCfq1TU1w4qufvUC59a4t/ygk3elt1xDru/o?=
 =?us-ascii?Q?fePND42o/jxQYXB9y0qxBnZeuecyG8484DVaj21o0BgcANVr/Jp4HYJAK/Qc?=
 =?us-ascii?Q?DwBsneY5cRGRzeEVw41dsWZEIZqBIj6tWMsHpWPeQh3kBjhYY9mXU7GD+d4f?=
 =?us-ascii?Q?tZWaL80JB3/pjlCL5f8DBo5w6K1Lu8pcCT8X9g2IkoxkVgO2PJCMoQL8Ur/C?=
 =?us-ascii?Q?zPKieFGAEebXL7JK90YH9fAMRf07EAOnIGLnZHOi70MQbiiF8RnFgrBoRy4Y?=
 =?us-ascii?Q?Aj0z911FJNAZFuzApidYtncdb+NQ1tpiXzhAGFQUKyOqlsbf+RzXUQ1htXvK?=
 =?us-ascii?Q?6cpk8uKMt2mbGMFL90glJrEQ6B5vmWIvv14Iu6Ye4Yp4V9eRGd3e3nrGIKS6?=
 =?us-ascii?Q?YXLuWUYuclGn60GXTN6BwZhVGjTZyx6QrPesj9CeTiJXqqwRRwKo8XUXJFEU?=
 =?us-ascii?Q?ipEV3ioM55lpaYPQOaUMDNJugNRtkaU5EthLCGCdJ6+VqzecLxfGduvqnzKf?=
 =?us-ascii?Q?WEdphrVAucWMXGj8MCUP89cwjqOD5dm3LChZj/V7ocfxSpr2P0jCFr9IHahi?=
 =?us-ascii?Q?87uLkVyPSRlCfhtxGnZDwQBd+wITF/ndsEzSjs5p0G6IHWoTKRCMtcXAcJZX?=
 =?us-ascii?Q?m5kfi/7+ILohj2opPOuZ/dtop3JdEwVjnzX6fnQC0aO1bmPNScH/hZctFPSA?=
 =?us-ascii?Q?d31BAx9CxBDgyoJYV/JNrqLLYHtuBEEjB5U27wISL99IvAHk9w05CCzSZqfT?=
 =?us-ascii?Q?DfO8Azrz7GXxITz0Kgo1bL4CsU4C7MA0yIjF7etG/RqcO3lgmsaN7t/g00lX?=
 =?us-ascii?Q?g4zjop13SunR9oQnOP3aCbKIJa+J5Zh0LtEC/FhxYbYd67m3Q44HazwOm/2t?=
 =?us-ascii?Q?OmFzEPpqguq+CJgfiakuMHDPntI86C/bTsR64NsR?=
X-OriginatorOrg: ni.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1fa02e56-2581-4720-ab85-08db405eefc7
X-MS-Exchange-CrossTenant-AuthSource: SN6PR04MB4973.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Apr 2023 22:47:50.6792
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 87ba1f9a-44cd-43a6-b008-6fdb45a5204e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8lUEVfA9oBXdprPsjEHZ1KXE10azavhuM9bYV8nlvevoo8+lG6KURDeUltwhNFgu1UBfz6Y9lkhK8z4Hvv30LA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB6761
X-Proofpoint-ORIG-GUID: bsAJpKaN2rAri8d6NopUKW8TqYRWI7EJ
X-Proofpoint-GUID: bsAJpKaN2rAri8d6NopUKW8TqYRWI7EJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-18_15,2023-04-18_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_policy_notspam policy=outbound_policy score=30
 priorityscore=1501 mlxscore=0 bulkscore=0 phishscore=0 malwarescore=0
 adultscore=0 clxscore=1015 spamscore=0 impostorscore=0 mlxlogscore=999
 suspectscore=0 lowpriorityscore=0 classifier=spam adjust=30 reason=mlx
 scancount=1 engine=8.12.0-2303200000 definitions=main-2304180191
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes from v2 -> v3;
- Schema fixes:
  - add "clocks" and "clock-names" properties, comment legacy use of
    "clock-frequency".
- Driver fixes:
  - get clock rate as a clock consumer, if available

Changes from v1 -> v2:
- Schema fixes:
  - Fix schema to now pass "make DT_CHECKER_FLAGS=-m dt_binding_check"
  - Rename unprefixed "transceiver" to "ni,serial-port-mode" with a
    description. Describing this as a "mode" rather than a "transceiver"
    seems more semantically correct in comparison to other DTs; other
    schemas with a "transceiver" property (isp1301, lpc32xx-udc) have
    phandle values, which is not the case here.
- Driver fixes:
  - replace C99 integer types with kernel types
  - reverse christmas tree
  - stuff PMR mode/cap masks into locals to avoid repetition
  - wrap ACPI match table in #ifdef CONFIG_ACPI to avoid build error on
    non-ACPI platforms
  - NI 16550s are only on x86 and Zynq-7000 NI devices, so constrain the
    Kconfig "depends" to only present it as an option to users on those
    architectures, to prevent it from being needlessly built on platforms
    that would not possibly have them.
  - document module name
  - add check for "ni,serial-port-mode" property; "transceiver" remains
    for sake of compatibility with _DSD ACPI objects for NI controller
    BIOSes currently in-field (but also DSD-properties-rules.rst says
    that _DSD properties don't have to be identical to DT bindings.)

Brenda Streiff (2):
  dt-bindings: serial: ni,ni16650: add bindings
  serial: 8250: add driver for NI UARTs

 .../bindings/serial/ni,ni16550.yaml           |  64 +++
 MAINTAINERS                                   |   7 +
 drivers/tty/serial/8250/8250_ni.c             | 467 ++++++++++++++++++
 drivers/tty/serial/8250/Kconfig               |  13 +
 drivers/tty/serial/8250/Makefile              |   1 +
 5 files changed, 552 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/serial/ni,ni16550.yaml
 create mode 100644 drivers/tty/serial/8250/8250_ni.c

-- 
2.30.2

