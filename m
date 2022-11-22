Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0476634511
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 21:00:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233887AbiKVUAX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 15:00:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231808AbiKVUAT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 15:00:19 -0500
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2084.outbound.protection.outlook.com [40.107.247.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27D77275E5;
        Tue, 22 Nov 2022 12:00:18 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fQeUKHh9od1/vPr8rfGeudvFyDru0Ea4pRgGKbIeKCRzRE1zwCvCtCMIGbCxi/ZU52NbgPKIUwIyS8syLevVGWGkNV0yMqRWxcSkU0ry28au9GUJaopkbuAD7cQ0mmeBZ5BtOoMhu1dXh309o0rFQZFuVYhPWNM8iiebv8kXZilfvXGD0iBbRUH2jBFSU2VypZbHhfAUNvu7DSAj0LVqzLyAF9ORZFdAHaPH0Vx9hXRr+XJWnPXIbjVCEyVa/fjqSXgWBryKaqC2TWu17N/AbGq1eNpBx32gag1UnFzn+Yihw0+vw/XoBWnkoah7LI5fJ9Fxo8+LSMgBqff6hOCr1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=icphm0/FYYfg7ngaN5BuwSbN9CVfs5dZl/UNlfCKSJs=;
 b=d9Ll9YAdDd+mOkMljv9dQHK1elpyf6I51G9hvR9JGY3G3Rpb3AzCxkVZvP5Nc9eqBe4FqeSiRlfz7oXGbP67a+vzi8h6ryubzmgR/82zRKt9rWZE1o0ca2BQHMIWT7aLhwvgwvE3Fl2zHTV+safb6JbspGU1cJtCcNfSFDyMq+UvVlU9Eni+wQQWlddm0ct9guV6gxfjKOaII3l52cHYDEWsI5BUsLyHW7ZMW5+QRsLM/YjbUYs3aqxbb1OA7Bag8zDzMhENSyIRrvwVQt9LXkov8a8HtxAcTOE8Bga1ciA8n+o6lG8GtyvSHpKkOuMBG6CN1BlG/y3zxMzTqjQv1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=icphm0/FYYfg7ngaN5BuwSbN9CVfs5dZl/UNlfCKSJs=;
 b=j+08cPklEQjsV9u4CWF53sK8ZVsDWnek93a6SLMAkpb6J18UBcZAGicWVg8ZBS7MkA/iKXdE4kI60xn4if3lLtvHHqn9oQZ7us6f0ELGAy/7AtKTi07XcGtqCENk+f6qpSFhGAcY0AprLTkHUpl/e3FpGjt81zpqDmf26o8kDXoCA75osBg1SVXuUr7VG4Yv7IHo6T3SETNinNjwlspBzUFeLxFsp/mq3dl8Tru8L7SzaZb8S8xySiBsjvlYtqXHVdgFM3v1iGVhoPdU6DIfWb712eT4slFag8uNACzaqBz1jGi/zqjR1WML6myEuRJ6ZScMaF5ZXm1UHgeOx2uaXg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from AM5PR04MB3089.eurprd04.prod.outlook.com (2603:10a6:206:b::28)
 by PAXPR04MB8751.eurprd04.prod.outlook.com (2603:10a6:102:20d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.9; Tue, 22 Nov
 2022 20:00:16 +0000
Received: from AM5PR04MB3089.eurprd04.prod.outlook.com
 ([fe80::88c9:1477:70d9:86e9]) by AM5PR04MB3089.eurprd04.prod.outlook.com
 ([fe80::88c9:1477:70d9:86e9%5]) with mapi id 15.20.5834.015; Tue, 22 Nov 2022
 20:00:16 +0000
Message-ID: <4d21f806-6653-5457-918c-563a3032d128@suse.com>
Date:   Tue, 22 Nov 2022 12:00:09 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH] scsi:iscsi: Record session's startup mode in kernel
Content-Language: en-US
To:     Wenchao Hao <haowenchao@huawei.com>,
        Chris Leech <cleech@redhat.com>,
        Mike Christie <michael.christie@oracle.com>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        open-iscsi@googlegroups.com, linux-scsi@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, liuzhiqiang26@huawei.com,
        linfeilong@huawei.com
References: <20221122213040.4128105-1-haowenchao@huawei.com>
From:   Lee Duncan <lduncan@suse.com>
In-Reply-To: <20221122213040.4128105-1-haowenchao@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0038.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:48::21) To AM5PR04MB3089.eurprd04.prod.outlook.com
 (2603:10a6:206:b::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM5PR04MB3089:EE_|PAXPR04MB8751:EE_
X-MS-Office365-Filtering-Correlation-Id: ad1f6243-f5ef-4567-34c5-08daccc42c71
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uSw6VGAqWGC36w3T4/Xqx7HhBtdZFqPt4y/0XxeY5MMxjH27n1L0yec/EGF/EF5Vp+O3jGm7QFa5Nu3+ePR/Os/vpYeR0jaaJohJMzNX9kalDoLnpqitWexUHVrw00tjwCCvA6ugVDC6DxP4+OwEhttUaXTUnSqYrWwxGaby4qgHKdbCzuPMZGIa23kP21p/EOpsMXor0KBW+DzpscAuW8Da0XOFB5zcgTqn/qEOryS0V/tEdlrqg2Y95Bq7In5wj+jpEy4EbLHIEWqcFCrTnSmaibTUo+V4I47UjLS+2KZd7rBPR54mYomQON+8O2JDWujkCYoYEATt2C/nbwuKXzhVSQj8Hyyn896xWChxsmupx4iPdY7mZrurFyJbPmOv77gGUPXQDWeZ7yfaDX8r+03c/BHnCm8nF+6tER/y/e2f3MCVlGIOGZGLbsOysOCtqshFvEaHN6RgAdHkkn8xBotW8MHef+opGFLQMPmuBiRHIFXWRPsmMJvAj7vv5ABfhyY0IWpbtflU7oh4Vy2AGlSjAR9vawGKPK5TC/q1tgp/57negnxR8CvT+NhtNL3+I5WhdNQapoZ3BVuf9f9goBNZ7f8a7BgRFkIqCI9fRJIPnfVqXPv6PnaPhA3tWmpmy7ZUS755L8Vv1tu+aX789YfTRRYYW804kyUP1Dj/nx0c0JrstkBdUog+XMGr8YqoJqS5m39tpenHQUnESnuCCA3DYtIbrcmyxnAChdc3SHw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM5PR04MB3089.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(346002)(39860400002)(366004)(136003)(376002)(451199015)(83380400001)(86362001)(41300700001)(66476007)(38100700002)(31696002)(2906002)(7416002)(478600001)(8936002)(5660300002)(53546011)(6666004)(6506007)(2616005)(4326008)(6512007)(6486002)(66946007)(8676002)(66556008)(316002)(186003)(26005)(110136005)(36756003)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eXAyVlIyQU1hbmVHaCtONHBia0VHU2t0ZXBRRmhKTm14Y0I4eVBZZFY1Z0gw?=
 =?utf-8?B?djE2Unc0azBUUFhsMjZvSVZYRUFZNHVWWjNtWHBKcTZQSmhmMDlWcHg4MkpC?=
 =?utf-8?B?OXN6cDZHUFh0cldYUzRRZGJaandGQ1A3TXk2NEJZV2phRS9XaGNSNStUSjJl?=
 =?utf-8?B?OEd0TXlvOTQ4T1BmSEtmcjk5S2lZeFRVSHdQTWIzRFptMU5hVW1FNThZTHpE?=
 =?utf-8?B?UEZSd2ZWQUJtcmpxY281Rk9hKzlYSld6L004NG9kdXVzdm16SEQzOHV6bG9L?=
 =?utf-8?B?R0xCU0V2dlloSGF1S2JzRnYyWHNlbXdnSEF1QW5yZktHOUU5UEtLc2x3TXFH?=
 =?utf-8?B?eXVTbVNUazYyT245dFVaaFJQYW1Pdjg1cUt6MXBNdS9HcEluYmIwMWVPQkJS?=
 =?utf-8?B?MmRoRU9iRXZRQXhERnlYT1c1ZzdRbElEUlFSSWhYYXMwR3RXMzU5MUcyUmNp?=
 =?utf-8?B?Z1lURVViUWY1dGkyeUVTQ0w0ME9kUXVuRCtvN05RTHI2Ui9GMUNKMmhHcVMv?=
 =?utf-8?B?WHNJNTdLSi9zY0wxUjgyckRINzNSbFdxeTRHWlFNR0FIUS8zT1E5UUE5ZXdU?=
 =?utf-8?B?WlY5WWJ5cmxNY2xaRGtHVEE0MlhoanpEQnh3S0JYcHVQWXFCM3N6eFVicEFl?=
 =?utf-8?B?M3UyQjlaTW1DbDBPOFVaS3F0SHNuTTVtbXIvTG5nSThTRG12dXNXNGdpb3RO?=
 =?utf-8?B?V3NQY2x1OVZPM3c5R3JCN0Y4b2NNTjFrcm54VjRndXZSRnZGb21FdGczQUxV?=
 =?utf-8?B?K3lZMUtDMnVPUGhmTzNoMWFsM2JCOWVRKzZUZDdoVVZsTEhEUWRuUlgvellX?=
 =?utf-8?B?bmFhdzY5QWp5bWR6aGRUYThmVVZYaEZHeTMya243MkN1K3ZyRzNzbGlhcDRP?=
 =?utf-8?B?TDYzUFloR2QrbHNycy9XU3l0Z2tLU2dkUXBoVnJQc3A3Z21FQUhKeHVuUDQ4?=
 =?utf-8?B?aERLTDJpb1pJbzJzdzdNUnIrVTlsVy9WcVRad2hRaEVZV0I1RnhNbjZ0Z2No?=
 =?utf-8?B?K3ROUFcrRHdCWHpBUkZsalg0Y2VqeTBIZjhZdHFXREpxdnlIdHZ4dUxrSkpW?=
 =?utf-8?B?cXJwVVl6WjBhL3pNUmpaUWtybTcrN2dlQTNlKzMrZitiZksxWDBISUFjMDdv?=
 =?utf-8?B?eVNDRzc1UXd1bmRtVGQ0S29YOTlsVTdRUXhnZml2U3lwUFNoVzI2cFV0SG1O?=
 =?utf-8?B?Z0lndUxhalhtL2pNcm1wVHdjelltOXRPQWYwYWJrZjFDWlRWcE8rZHk0Vmhi?=
 =?utf-8?B?cUZxMll2U2NHQWlLd0lOaXlRL0kzaC9CUnlzVEFkYXZOM2NWZllkcUIrMUxw?=
 =?utf-8?B?SURuMHFXNXhlclNRYjgvVDFRYkhGOGYwN3NBakhWVGorVzNNbEV0NzZiT2Zo?=
 =?utf-8?B?eE1DSnV0Tmwvc3JWcVhENEpBd2x0aUkzaGtmbit2eE5OZlAvUi9mcitNTlE0?=
 =?utf-8?B?dTN4ZFVhWXBXVVh3OWcycElYQXBPbnlIWVN6bnBINEhLZ0ZoUmdFcjAzTjUv?=
 =?utf-8?B?ZC9VUkx3RGFVek55NUFoS2J6YTdDSjdLbkU3Z240Rmd1LzRPVEdPeE11aHhR?=
 =?utf-8?B?bEhxZXk2cWhVait4RE1ZdUFJMU5oZ3pON1hRa2lUTll3b3M2VjNUYVBmcWhP?=
 =?utf-8?B?dHl3eGV3Nm1pVGRKWU9WZktoWGtWOTBuNDllNWNCNll2M0JBRDg0Y0s5UzVH?=
 =?utf-8?B?R3o5a1VpODU5YmZ1aWRRTndqNFBJdFJUMEJuK1Zld1RJZEovdG1WQ3dkYVFi?=
 =?utf-8?B?ZThLU28rOGtnWXo2eUovY3hXZGNMYXdPWUhHN1Ywc09iNVFsb2ZDQTd1aTNO?=
 =?utf-8?B?VEJQK0lNTzhTeFhTcGx6cEVsVkNTQWJNSU9hTTBGYUpwQ1ByZmZUQ3VMcmdL?=
 =?utf-8?B?bWZqRnZtWVhrZXRUTDNRUU82UkthVEdHenZxMlltand0MmYrbE5vUWpLeUdN?=
 =?utf-8?B?NndIRUNIZjFhWnRpNWpVbGFhcXd5RVo4b2xrNk5aQ2dkdU5UNTBwbkJ5TUcw?=
 =?utf-8?B?b1R5SkJSQWc4bEtwMXgxK2dIUXBrWnJ1STZKVkkwMXJuL25XRUxHRzVvcmNm?=
 =?utf-8?B?RkI4TnowMi83UmxSNVRCeVJrajdvc21DNVMvd1AzYXladEhmZkhXUG0xT0py?=
 =?utf-8?Q?gaVcoByKGQB9kEx65eyG8T+6T?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad1f6243-f5ef-4567-34c5-08daccc42c71
X-MS-Exchange-CrossTenant-AuthSource: AM5PR04MB3089.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2022 20:00:15.9025
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: div1SbLpXS1wwMa7qxJrY9Qan8IA5pL/n7xzAm+8/Hkz7EapQDPPSsJ/U1q3S6vLrnNZgxclMjkjmKdcJHQDkA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8751
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/22/22 13:30, Wenchao Hao wrote:
> There are 3 iscsi session's startup mode which are onboot, manual and
> automatic. We can boot from iSCSI disks with help of dracut's service
> in initrd, which would set node's startup mode to onboot, then create
> iSCSI sessions.
> 
> While the configure of onboot mode is recorded in file of initrd stage
> and would be lost when switch to rootfs. Even if we update the startup
> mode to onboot by hand after switch to rootfs, it is possible that the
> configure would be covered by another discovery command.
> 
> root would be mounted on iSCSI disks when boot from iSCSI disks, if the
> sessions is logged out, the related disks would be removed, which would
> cause the whole system halt.
> 
> So we need record session's start up mode in kernel and check this
> mode before logout this session.
> 
> Signed-off-by: Wenchao Hao <haowenchao@huawei.com>
> ---
>   drivers/infiniband/ulp/iser/iscsi_iser.c | 1 +
>   drivers/scsi/be2iscsi/be_iscsi.c         | 1 +
>   drivers/scsi/bnx2i/bnx2i_iscsi.c         | 1 +
>   drivers/scsi/cxgbi/libcxgbi.c            | 1 +
>   drivers/scsi/iscsi_tcp.c                 | 1 +
>   drivers/scsi/libiscsi.c                  | 5 +++++
>   drivers/scsi/qedi/qedi_iscsi.c           | 1 +
>   drivers/scsi/qla4xxx/ql4_os.c            | 1 +
>   drivers/scsi/scsi_transport_iscsi.c      | 4 ++++
>   include/scsi/iscsi_if.h                  | 1 +
>   include/scsi/libiscsi.h                  | 1 +
>   11 files changed, 18 insertions(+)
> 
> diff --git a/drivers/infiniband/ulp/iser/iscsi_iser.c b/drivers/infiniband/ulp/iser/iscsi_iser.c
> index 620ae5b2d80d..778c023673ea 100644
> --- a/drivers/infiniband/ulp/iser/iscsi_iser.c
> +++ b/drivers/infiniband/ulp/iser/iscsi_iser.c
> @@ -947,6 +947,7 @@ static umode_t iser_attr_is_visible(int param_type, int param)
>   		case ISCSI_PARAM_IFACE_NAME:
>   		case ISCSI_PARAM_INITIATOR_NAME:
>   		case ISCSI_PARAM_DISCOVERY_SESS:
> +		case ISCSI_PARAM_NODE_STARTUP:
>   			return S_IRUGO;
>   		default:
>   			return 0;
> diff --git a/drivers/scsi/be2iscsi/be_iscsi.c b/drivers/scsi/be2iscsi/be_iscsi.c
> index 8aeaddc93b16..a21a4d9ab8b8 100644
> --- a/drivers/scsi/be2iscsi/be_iscsi.c
> +++ b/drivers/scsi/be2iscsi/be_iscsi.c
> @@ -1401,6 +1401,7 @@ umode_t beiscsi_attr_is_visible(int param_type, int param)
>   		case ISCSI_PARAM_LU_RESET_TMO:
>   		case ISCSI_PARAM_IFACE_NAME:
>   		case ISCSI_PARAM_INITIATOR_NAME:
> +		case ISCSI_PARAM_NODE_STARTUP:
>   			return S_IRUGO;
>   		default:
>   			return 0;
> diff --git a/drivers/scsi/bnx2i/bnx2i_iscsi.c b/drivers/scsi/bnx2i/bnx2i_iscsi.c
> index a3c800e04a2e..d1fb06d8a92e 100644
> --- a/drivers/scsi/bnx2i/bnx2i_iscsi.c
> +++ b/drivers/scsi/bnx2i/bnx2i_iscsi.c
> @@ -2237,6 +2237,7 @@ static umode_t bnx2i_attr_is_visible(int param_type, int param)
>   		case ISCSI_PARAM_BOOT_ROOT:
>   		case ISCSI_PARAM_BOOT_NIC:
>   		case ISCSI_PARAM_BOOT_TARGET:
> +		case ISCSI_PARAM_NODE_STARTUP:
>   			return S_IRUGO;
>   		default:
>   			return 0;
> diff --git a/drivers/scsi/cxgbi/libcxgbi.c b/drivers/scsi/cxgbi/libcxgbi.c
> index af281e271f88..111b2ac78964 100644
> --- a/drivers/scsi/cxgbi/libcxgbi.c
> +++ b/drivers/scsi/cxgbi/libcxgbi.c
> @@ -3063,6 +3063,7 @@ umode_t cxgbi_attr_is_visible(int param_type, int param)
>   		case ISCSI_PARAM_TGT_RESET_TMO:
>   		case ISCSI_PARAM_IFACE_NAME:
>   		case ISCSI_PARAM_INITIATOR_NAME:
> +		case ISCSI_PARAM_NODE_STARTUP:
>   			return S_IRUGO;
>   		default:
>   			return 0;
> diff --git a/drivers/scsi/iscsi_tcp.c b/drivers/scsi/iscsi_tcp.c
> index 5fb1f364e815..47a73fb3e4b0 100644
> --- a/drivers/scsi/iscsi_tcp.c
> +++ b/drivers/scsi/iscsi_tcp.c
> @@ -1036,6 +1036,7 @@ static umode_t iscsi_sw_tcp_attr_is_visible(int param_type, int param)
>   		case ISCSI_PARAM_TGT_RESET_TMO:
>   		case ISCSI_PARAM_IFACE_NAME:
>   		case ISCSI_PARAM_INITIATOR_NAME:
> +		case ISCSI_PARAM_NODE_STARTUP:
>   			return S_IRUGO;
>   		default:
>   			return 0;
> diff --git a/drivers/scsi/libiscsi.c b/drivers/scsi/libiscsi.c
> index d95f4bcdeb2e..1f2b0a9a029e 100644
> --- a/drivers/scsi/libiscsi.c
> +++ b/drivers/scsi/libiscsi.c
> @@ -3576,6 +3576,8 @@ int iscsi_set_param(struct iscsi_cls_conn *cls_conn,
>   		break;
>   	case ISCSI_PARAM_LOCAL_IPADDR:
>   		return iscsi_switch_str_param(&conn->local_ipaddr, buf);
> +	case ISCSI_PARAM_NODE_STARTUP:
> +		return iscsi_switch_str_param(&session->node_startup, buf);
>   	default:
>   		return -ENOSYS;
>   	}
> @@ -3712,6 +3714,9 @@ int iscsi_session_get_param(struct iscsi_cls_session *cls_session,
>   		else
>   			len = sysfs_emit(buf, "\n");
>   		break;
> +	case ISCSI_PARAM_NODE_STARTUP:
> +		len = sysfs_emit(buf, "%s\n", session->node_startup);
> +		break;
>   	default:
>   		return -ENOSYS;
>   	}
> diff --git a/drivers/scsi/qedi/qedi_iscsi.c b/drivers/scsi/qedi/qedi_iscsi.c
> index 31ec429104e2..b947a5bca380 100644
> --- a/drivers/scsi/qedi/qedi_iscsi.c
> +++ b/drivers/scsi/qedi/qedi_iscsi.c
> @@ -1437,6 +1437,7 @@ static umode_t qedi_attr_is_visible(int param_type, int param)
>   		case ISCSI_PARAM_BOOT_ROOT:
>   		case ISCSI_PARAM_BOOT_NIC:
>   		case ISCSI_PARAM_BOOT_TARGET:
> +		case ISCSI_PARAM_NODE_STARTUP:
>   			return 0444;
>   		default:
>   			return 0;
> diff --git a/drivers/scsi/qla4xxx/ql4_os.c b/drivers/scsi/qla4xxx/ql4_os.c
> index 9e849f6b0d0f..1cb7c6dbe9d3 100644
> --- a/drivers/scsi/qla4xxx/ql4_os.c
> +++ b/drivers/scsi/qla4xxx/ql4_os.c
> @@ -468,6 +468,7 @@ static umode_t qla4_attr_is_visible(int param_type, int param)
>   		case ISCSI_PARAM_DISCOVERY_PARENT_IDX:
>   		case ISCSI_PARAM_DISCOVERY_PARENT_TYPE:
>   		case ISCSI_PARAM_LOCAL_IPADDR:
> +		case ISCSI_PARAM_NODE_STARTUP:
>   			return S_IRUGO;
>   		default:
>   			return 0;
> diff --git a/drivers/scsi/scsi_transport_iscsi.c b/drivers/scsi/scsi_transport_iscsi.c
> index c3fe5ecfee59..39c14d2a8aad 100644
> --- a/drivers/scsi/scsi_transport_iscsi.c
> +++ b/drivers/scsi/scsi_transport_iscsi.c
> @@ -4367,6 +4367,7 @@ iscsi_session_attr(tsid, ISCSI_PARAM_TSID, 0);
>   iscsi_session_attr(def_taskmgmt_tmo, ISCSI_PARAM_DEF_TASKMGMT_TMO, 0);
>   iscsi_session_attr(discovery_parent_idx, ISCSI_PARAM_DISCOVERY_PARENT_IDX, 0);
>   iscsi_session_attr(discovery_parent_type, ISCSI_PARAM_DISCOVERY_PARENT_TYPE, 0);
> +iscsi_session_attr(node_startup, ISCSI_PARAM_NODE_STARTUP, 0);
>   
>   static ssize_t
>   show_priv_session_state(struct device *dev, struct device_attribute *attr,
> @@ -4488,6 +4489,7 @@ static struct attribute *iscsi_session_attrs[] = {
>   	&dev_attr_sess_def_taskmgmt_tmo.attr,
>   	&dev_attr_sess_discovery_parent_idx.attr,
>   	&dev_attr_sess_discovery_parent_type.attr,
> +	&dev_attr_sess_node_startup.attr,
>   	NULL,
>   };
>   
> @@ -4587,6 +4589,8 @@ static umode_t iscsi_session_attr_is_visible(struct kobject *kobj,
>   		return S_IRUGO;
>   	else if (attr == &dev_attr_priv_sess_target_id.attr)
>   		return S_IRUGO;
> +	else if (attr == &dev_attr_sess_node_startup.attr)
> +		param = ISCSI_PARAM_NODE_STARTUP;
>   	else {
>   		WARN_ONCE(1, "Invalid session attr");
>   		return 0;
> diff --git a/include/scsi/iscsi_if.h b/include/scsi/iscsi_if.h
> index 5225a23f2d0e..e46e69c1fd02 100644
> --- a/include/scsi/iscsi_if.h
> +++ b/include/scsi/iscsi_if.h
> @@ -610,6 +610,7 @@ enum iscsi_param {
>   	ISCSI_PARAM_DISCOVERY_PARENT_IDX,
>   	ISCSI_PARAM_DISCOVERY_PARENT_TYPE,
>   	ISCSI_PARAM_LOCAL_IPADDR,
> +	ISCSI_PARAM_NODE_STARTUP,
>   	/* must always be last */
>   	ISCSI_PARAM_MAX,
>   };
> diff --git a/include/scsi/libiscsi.h b/include/scsi/libiscsi.h
> index 654cc3918c94..af4ccdcc1140 100644
> --- a/include/scsi/libiscsi.h
> +++ b/include/scsi/libiscsi.h
> @@ -327,6 +327,7 @@ struct iscsi_session {
>   	char			*boot_target;
>   	char			*portal_type;
>   	char			*discovery_parent_type;
> +	char			*node_startup;
>   	uint16_t		discovery_parent_idx;
>   	uint16_t		def_taskmgmt_tmo;
>   	uint16_t		tsid;

The iscsiadm/iscsid tools refuse to logout of an ONBOOT session.

-- 
Lee Duncan

