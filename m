Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C91717413B6
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 16:20:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231894AbjF1OSB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 10:18:01 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:7408 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229840AbjF1ORv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 10:17:51 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35SBTPkZ011307;
        Wed, 28 Jun 2023 14:17:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=tSC/GXjNbcyPl7OKYXFWgtdlkM6enmJT6Mg9k9cpZ6s=;
 b=tTo1iwH27SO7mGM2NPKM83JC2DCXXQUArG+ui+nPMeYB207DbFIXPQ4oxN+yvNrXKBOX
 0XgDD44czojIrnPDuLfkKrqTWKKaShhzNQm8JDK7sC91luurEC7FswShWMZYAaWeeBIr
 AzYZabrh30o1OCymWtIX7bj86FgNXrSYvayB1DR7FHgBvHqwTbfznktTPsxg40P3ijeR
 hL4kmYLPMvcnokUBs7ZxcC/qeC0Imov6FYA3jjrJREpNCAEN6gaIQKuxXd8SW4gpeVEo
 xfMtrbAdKA/b3e/MQXPEZthbbEg/VJoMzxBA73lUGSiD9ZTcgFK49UsVbIZ4DrXYiPcZ OQ== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3rds1u7gyw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 28 Jun 2023 14:17:21 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 35SDAftt008678;
        Wed, 28 Jun 2023 14:17:20 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3rdpx62jcy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 28 Jun 2023 14:17:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TkOa9aoFUsmYs00WIs2IiFHaozFXK7U2iuELLShxI1bl9BXyUFcBusJv+4MeXVnql9zBM+qPmWSy5eq7aX45Jd2yqxD/yFlxjTSvOBZveem5bUoP18P/VYMzlcCDVloLG67hdyFojoRd8mKzu/KdBP4yEhsHK0gGKyVe5xRUsllbc0PA9M1n3UbkpnAnls1yZWPLKJ3EF1w9ceGKjrE5VoWYcLK9O0NjLv5LwtVbuYxBexMSiU0NedP+26QkNzXcLx85OwSPRcv9xSnYx7SW3MKpr9qN3xA/aIWfw5TrdkeLRuO2lftVLKfZhhTrgSy3+c+kLyQUqB+RqYPHGiJVXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tSC/GXjNbcyPl7OKYXFWgtdlkM6enmJT6Mg9k9cpZ6s=;
 b=frf9hBcy4lRNUvbNZuUgjOWgJ9Ml1w6NU1+Y0Cjffi4SKyB+/mctTznj6QwOQF6R8nGjse2zNrcVJl0nxzQq//ijkArPq33ZJXAk081YBktX5IrC86af3C7ECKLbAKUGYwltHwzmQ0GMHMlHRiA4FCtaW3+ySgKTg2o76qy6UdW52eBXeIpybKwroh/6lDd5WSFvW4P0LTuOwnbxwsFENFebvf12IVCP7aKwgUFLXTj5PWCYDhGsBoH8O4RII1R3TzhSZphRPQcGTOfwBIf0qjApXd0Zw6akXt26NCUuT/c7G4ei3p+KPbn3OfvNmUmwZa7JmxzXOVXhO8qt5fIAuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tSC/GXjNbcyPl7OKYXFWgtdlkM6enmJT6Mg9k9cpZ6s=;
 b=ihe/vVUMBlGYE6VB6/Ha67p0tTzMSWotQs/W7Vnu5lmDSS6bFANafuOKNtKJwWrdc/ty0GAJ5k1v6dEy96f0NvXVGiX4uiT7x46fz7ZwO96QObv+ImkjjyD1Lknwd5rZ8bsyIz+sS3UELsZoV5ktPyMqd7ehI0wH6i5KaJ76Qqg=
Received: from MW5PR10MB5738.namprd10.prod.outlook.com (2603:10b6:303:19b::14)
 by DS0PR10MB6125.namprd10.prod.outlook.com (2603:10b6:8:c7::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Wed, 28 Jun
 2023 14:17:18 +0000
Received: from MW5PR10MB5738.namprd10.prod.outlook.com
 ([fe80::9c17:d256:43b9:7e96]) by MW5PR10MB5738.namprd10.prod.outlook.com
 ([fe80::9c17:d256:43b9:7e96%6]) with mapi id 15.20.6521.023; Wed, 28 Jun 2023
 14:17:18 +0000
Message-ID: <66391bef-ab6c-7cad-3588-3f0a0dfb7d47@oracle.com>
Date:   Wed, 28 Jun 2023 09:17:15 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [Jfs-discussion] [PATCH 0/3] dedupe smb unicode files
Content-Language: en-US
To:     "Dr. David Alan Gilbert" <linux@treblig.org>,
        Tom Talpey <tom@talpey.com>
Cc:     sfrench@samba.org, linux-cifs@vger.kernel.org,
        jfs-discussion@lists.sourceforge.net, linkinjeon@kernel.org,
        linux-kernel@vger.kernel.org
References: <20230628011439.159678-1-linux@treblig.org>
 <9343462e-6a4a-ca7b-03b8-4855e5a33b72@talpey.com>
 <ZJw4iLlFWRMq6a3S@gallifrey> <ZJw50e0pvn/IN5Gj@gallifrey>
From:   Dave Kleikamp <dave.kleikamp@oracle.com>
In-Reply-To: <ZJw50e0pvn/IN5Gj@gallifrey>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR04CA0113.namprd04.prod.outlook.com
 (2603:10b6:610:75::28) To MW5PR10MB5738.namprd10.prod.outlook.com
 (2603:10b6:303:19b::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW5PR10MB5738:EE_|DS0PR10MB6125:EE_
X-MS-Office365-Filtering-Correlation-Id: 6f560b24-e712-4323-5f0c-08db77e2613e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3CViEPO2EXt2iC/LISrXD8XdyvqhcPBLnN+YfVWHWA/uS77PNqBnnNyOXmnndjGkR8AHCgCIFRX+LzCBNy8WCgc0qik6d5MS1uFTtrVK2gej0E8cKuEVJtzgPM4RdwIMBthkNf7NDW7XaAQzQtqEfYYsO73ZFgFkGsgxOyP4g2C7Jsb5JaUaX6u8byMETNtNUoan8m6T9S7+R/BqNl+bDplvZ/QuHz2fyyXeRyDsjWRxFC7mg0fULTmXuBr2dtYOCQTZPshh1NELAJ20/slRD5eaAqSY9rpHdWMWRAX4fuy0Q5jwN6wh1JpXVC+0vNzfBIcGLrVnp2S+q7EWGO1bLF6ajJQkUeXDH2t0vr+nnYIGrumvizh4mkyVNAXBFegAOju9RNfx8DJdOTnQN4MxSNyswnmENVcbnD0m+4LgXGS/A2QRiNhyqT19++pR+Cfr1xbEkBOMHAMH8FW1gYZm110OZEpDk3rm17imPvyverRWXng57YzBPEmvSZ9XyQqlm5lked/0fUUCWROmrf6f+OHQo6TDnflo5IKqfyF2VipgzHXm5S2/m+IPtN3KTAj6DAshTAQdaiW60n6804T74r9jUr5ZirVQJU52WYh/o2DKlpMyo0FEQ4j/AgUu+7O0TszFJFxHB2ZCw+pS9kqOoQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR10MB5738.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(396003)(39860400002)(136003)(366004)(346002)(451199021)(83380400001)(8936002)(6486002)(966005)(6666004)(316002)(110136005)(8676002)(4326008)(41300700001)(36756003)(31686004)(86362001)(31696002)(38100700002)(2616005)(44832011)(5660300002)(6512007)(66946007)(66556008)(66476007)(478600001)(2906002)(186003)(26005)(6506007)(53546011)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bEVPVUNtMVVqNlhYTWYyU2luSjJxSGxRRG9IeGNMNnVPRzR1WEhkNlVBL2dq?=
 =?utf-8?B?dGRSaVlXVkRSQkpOSEMvbWFOM0p0dHRrMFU1a1FDeFNLVk42VUZHaXVyMExK?=
 =?utf-8?B?YVgxU203cWEyZkkzKzJJR0k5OUZ0ZHZINFNTY2NjcS9Hd0Nva2FNZnp1VktT?=
 =?utf-8?B?bWVhdTRnWFl1cnhrbjhleXdrbGxzc2NHV2U0cVdUakJaeEpkc1BIUzVrdUI4?=
 =?utf-8?B?S1Z6bEpMaVdtUWo2REpPcEtsWm41N3g0TnRmTThyU3dub21ML3pRYW1HUlhU?=
 =?utf-8?B?VmJoOW9reS9hT0IwU3F3d0Q4eHd0V0lhT1Jmc3V1bm9ZeEpCcmxtQm9uUENn?=
 =?utf-8?B?MHd4OWRzcFcwd2tBYkI4MTJHcGpJdzArODVRaE40L1BOanhVcGVuanRkTDVE?=
 =?utf-8?B?KzVGUTRwaDdsbHVpNGNmcjFhMkQzTnBBeXo5R3M4TEF5UFZHQnpqaWVyWVdo?=
 =?utf-8?B?emw2TEJyempXdzA5YlovTkhSSTJHNzdiQlV6MnJXcEJjcUswUTZGM3JzcTdw?=
 =?utf-8?B?dDlkeGNFNUFiZHJxY3VyOHI1TkN2WWxNVjM2UmxGaWRiRVJSeUtCcXh1djIr?=
 =?utf-8?B?dGRmWW85M2JlK3luaXptSVdiMWpVUnlxOCtEVHF5THlPSExla2VwQ3hxb0Vz?=
 =?utf-8?B?RmsvZVI5TVVLWGJLT1Q3ZGx4cDBzS1U2bjg4bVFzTzNaMkU3ZGJhd21LVFor?=
 =?utf-8?B?U0ZqanhOSW9XcXBDNE1oT1JId29jZ0x5MlAxTElmb1ZRUE9XU2NIZ3lLZ3F6?=
 =?utf-8?B?dy82MjJnOGYxenpheXhtYjJDL2JlTm8zM2NSUk9VVWI3cFAwSkJiWWtSY3VQ?=
 =?utf-8?B?aFl1Mm1uSngxdVRDY2pyRTdpOWRGVkVhL3A3TUdRNVRqTnpGaTIrMXF4N0Nk?=
 =?utf-8?B?OUpCVWszZ2ZxQmJvNXdUdDJDRHo5QWZBV0FCUC9BNmtVRlVkaENxa25FWkQy?=
 =?utf-8?B?K0sveTl0alNWMnRoajZSZjFCY3pUK0Q2SGdzblRwbnAyS3NLenFSZjJ3ejBP?=
 =?utf-8?B?Tmo0Z1Nxa1RWczVERm5DanpteXB5QWRhZ2JvRlc2eSt3SU9uOHBHdkxSbkNp?=
 =?utf-8?B?UmhnMGJDSU4yNGY3b2xpU05zaytmazA2bVI5SThZbVBvTWQ3cEVIeUx1cVE2?=
 =?utf-8?B?cVB0VzFjMkVvek5DbmErQ3hrV3ZyZSs0SENHcjZiY1NzeFlKRDVqMXI2blkv?=
 =?utf-8?B?QjFOS3F6ajYyNWVhT0x5UDZDdCs1WXRqNWhIVlZESHJLYmNPci81YjQ0Smla?=
 =?utf-8?B?MWlFbVBRZ0d3dzk1blZSbnVBeFBkNnF4ajFNK0xsN0pSak91WUorbEZ5eVVB?=
 =?utf-8?B?dkt3WjBTT3NQMFJNTXp6ZFY0bE9tc2ZXWjdoWko0SXR0cUhTTzF3blQzVnF1?=
 =?utf-8?B?bS8zRURXTThCM00zNHNabE9VdG9aWFM2WE85bmZwNVNqU3hpNnh0VXdtZ3A4?=
 =?utf-8?B?eDB2S3hjQWV1Y1N1UktEbXp6VjNWSWkrTG9wdVJBcmRSOWxpR3QwMUplMWp6?=
 =?utf-8?B?TDN1dXFUYmp4b0ZJeGtTN0k3d3E5RlY4UndKUGU5bWV5NDBiQW1uVlplM2pz?=
 =?utf-8?B?VDNTUGJ5MmJEWUx5eXZYMVZwV3N6VndCM2Jrc3hTOXlSNVh1VkROamhERmxJ?=
 =?utf-8?B?WXJsRFJ4NWh2ekRVUG5vRWVBYmhTSjdQTmZqdG43WkMyQmpFNWszYkYzNkhq?=
 =?utf-8?B?NTZHL21DOForM3hnRkJoSjIzQTFwZ29va0hSQmRKM01iU0RoK2VZMStWTFBs?=
 =?utf-8?B?U29SVWdpcVZ6NE1jZlYvcGMyZjlFVm51UHpYSUE2UWlxSExaY0o4M3cyM2Jk?=
 =?utf-8?B?NlkzQkRYeU90VnJ3TWVVTzZrdW5mMHVFSFd4Tm9kRDZVYnFHbldJUUtkSzYy?=
 =?utf-8?B?S1FlTnFqS1dBRHJ3Z1hGUmROMGRocytqbHhTNFZWSE9HNGFuSHhZTWtiY1l3?=
 =?utf-8?B?K01iSXQ2VWVmakpZZEx2UmZrTDExNC9vOFVQQlQ2aDYyUUtuU1puaExlYUc3?=
 =?utf-8?B?M2k0dXdHbGFpY1Y1SlQ1dllkWGlZeFFYVzc1UnVJbHQ1RnFwTnBtd3VvN1E2?=
 =?utf-8?B?TlM4eWtFZkgrY1hGblN1OTE0Tm1VL05VcWVEMWZQRUpvbE9aVHgwOHRPZG9B?=
 =?utf-8?B?NE9EeC9zQzkvejFVYkcwTlhpbkJqK1NMejBES1djZU1iS2NxcTdHaE9kNS8r?=
 =?utf-8?B?Vmc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?VUVnUjhGY1BaWHBRdGU4WE5IazBnZzVXbFN1L1JIbmY1THQ2eHhBL1A2VW1K?=
 =?utf-8?B?dHZscC9ObHNselJyc2hzVVFmeFI3eVdlV1Bja2lRRHZCRUNWYUxxUTMzQ3RP?=
 =?utf-8?B?RXBVN2dHcWRoRFRiaGl0QTBWOTdubUxTKzRYbGhBR1dKQytWRDN1NE81eVpG?=
 =?utf-8?B?K2NaN0tGM0ZLVFJnYStTVWZTTytzNmxnemxDZmlmeUF0c2QxVmpkeVBoaWZP?=
 =?utf-8?B?RlpDZlA5K25ydUxKUUhQanlXQXhRZmlsU2NnMWJIU1FTc01jLzdOS0VJQS9a?=
 =?utf-8?B?T0pEczAxeE1UVURsbE5uL1dxVEtwWmRYTEZjY3pwM1hTWktjWUlpTGFhS3Vp?=
 =?utf-8?B?blYybVpxNjN0dzMxWGZ1eTQ4c21zd3dNbHNYZEJMV0tRRFc4SmMzeGlRWGtN?=
 =?utf-8?B?VUwxSkt6T05qRTEzNjZyQ3plaXMzTUlnUk4rRlpadXVqR2JqSE1uUEh6ZS9p?=
 =?utf-8?B?STBQeXFqb25KekE3L1dvRU5hTkF5SWcyL2ltbWFNNlJoSGI0QS9rSHJ4ajdF?=
 =?utf-8?B?MXRzRWMwNHhudDJGNzEzMUttMjR1VXFyMWtNNzJ6YjN1YVhXY1drM3NtOENl?=
 =?utf-8?B?M0NLVUNQTDdMQkxpcUh0eTNabXdCbGxiL1VuVlR2aDAwRkFRZGxtalZrQ2t0?=
 =?utf-8?B?VXowVzd5VHowVnZva25QUXBWV3djeUNtY01makdwSnRZZkJQV25QZ2lJSDVN?=
 =?utf-8?B?UU9yQ1NBWEJRa0J4RXhhYWp5ckpvL1FzdE05NWtIVWNESmRGVnpiTVlpWGRw?=
 =?utf-8?B?WDF3MU9xNzVmcjlOTVhLbVBacm1ZOTdyTm9FVkVyTnAyZjNhZm1oQ1hjWTgz?=
 =?utf-8?B?TUk2YlRCcFJsUmY0TFNJV1FyaWNza0Z1VlQyaU9NMzNOQ0pCd0ZYbTZTN3Bj?=
 =?utf-8?B?b2YzTVgxcTFiZnR5TjJKZExKS0gyWTdXRVhTQWFSc3VrOG00Rm96Vjh1M2xR?=
 =?utf-8?B?MkFYN25FYldRR3o1UmVqalp3OTNFRE1lUEx5bUJtbUtNQy9nTjBjdzFxOXU3?=
 =?utf-8?B?THVXRzFKVGZOeVpwenNnUGVkcmFMREVzUTl6S1NYdGVCUWtCZnFpdXA3c01V?=
 =?utf-8?B?b2p4dHUzZndiQmdWaGtOamhIbWlVYmZmVDl3SmtuS2hGTkc3SEdCMFlXVlEz?=
 =?utf-8?B?VTZMZk8wZ25aWHloMVNsMUZHYmlBemRIUzdOb01FZWpCeGdYaE04a3plU3Fy?=
 =?utf-8?B?ZExwTDZFaTJpMHVaSDVJYzFKNy9oamVQSzByNVZGR2hPYUZZSm40N0h3OTR5?=
 =?utf-8?Q?ltStYZCNXrOChCh?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f560b24-e712-4323-5f0c-08db77e2613e
X-MS-Exchange-CrossTenant-AuthSource: MW5PR10MB5738.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2023 14:17:18.2877
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BRu8BGCvTZP08TCpgGt4uaGXNDeD4Yhrz2vLVycAm58NyGzMSap8uPjVFyU+gkFol/gseTg5mcVjNYj+VivUoOSUcUxVEP7CBXfnmHIbodc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6125
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-28_10,2023-06-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 malwarescore=0 suspectscore=0 spamscore=0 bulkscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306280126
X-Proofpoint-GUID: LxhH3yE2A40habb3wvenCTNqkMKYUn4X
X-Proofpoint-ORIG-GUID: LxhH3yE2A40habb3wvenCTNqkMKYUn4X
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/28/23 8:46AM, Dr. David Alan Gilbert wrote:
> * Dr. David Alan Gilbert (dave@treblig.org) wrote:
>> * Tom Talpey (tom@talpey.com) wrote:
>>> On 6/27/2023 9:14 PM, linux@treblig.org wrote:
>>>> From: "Dr. David Alan Gilbert" <linux@treblig.org>
>>>>
>>>> The smb client and server code have (mostly) duplicated code
>>>> for unicode manipulation, in particular upper case handling.
>>>>
>>>> Flatten this lot into shared code.
>>>>
>>>> There's some code that's slightly different between the two, and
>>>> I've not attempted to share that - this should be strictly a no
>>>> behaviour change set.
>>>>
>>>> I'd love to also boil out the same code from fs/jfs/ - but that's
>>>> a thought for another time (and harder since there's no good test
>>>> for it).
>>>>
>>>> Lightly tested with a module and a monolithic build, and just mounting
>>>> itself.
>>>>
>>>> This dupe was found using PMD:
>>>>     https://pmd.github.io/pmd/pmd_userdocs_cpd.html
>>>>
>>>> Dave
>>>>
>>>> Dr. David Alan Gilbert (3):
>>>>     fs/smb: Remove unicode 'lower' tables
>>>>     fs/smb: Swing unicode common code from server->common
>>>>     fs/smb/client: Use common code in client
>>>>
>>>>    fs/smb/client/cifs_unicode.c                  |   1 -
>>>>    fs/smb/client/cifs_unicode.h                  | 313 +-----------------
>>>>    fs/smb/client/cifs_uniupr.h                   | 239 -------------
>>>>    fs/smb/common/Makefile                        |   1 +
>>>>    .../uniupr.h => common/cifs_unicode_common.c} | 156 +--------
>>>>    fs/smb/common/cifs_unicode_common.h           | 279 ++++++++++++++++
>>>
>>> So far so good, but please drop the "cifs_" prefix from this new file's
>>> name, since its contents apply to later smb dialects as well.
>>
>> Sure.
> 
> Actually, would you be ok with smb_unicode_common ?  The reason is that
> you end up with a module named unicode_common  that sounds too generic.

A bit off topic, but a question for Steve.

Is there a need for separate modules under fs/smb/common/? Or could the 
makefile do something like:

obj-$(CONFIG_SMBFS) += smb_common.o

smb_common-y := cifs.arc4.o cifs_md4.o smb_unicode.o

Shaggy

> 
> Dave
> 
>> Dave
>>
>>> Tom.
>>>
>>>>    fs/smb/server/unicode.c                       |   1 -
>>>>    fs/smb/server/unicode.h                       | 301 +----------------
>>>>    8 files changed, 298 insertions(+), 993 deletions(-)
>>>>    delete mode 100644 fs/smb/client/cifs_uniupr.h
>>>>    rename fs/smb/{server/uniupr.h => common/cifs_unicode_common.c} (50%)
>>>>    create mode 100644 fs/smb/common/cifs_unicode_common.h
>>>>
>> -- 
>>   -----Open up your eyes, open up your mind, open up your code -------
>> / Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \
>> \        dave @ treblig.org |                               | In Hex /
>>   \ _________________________|_____ http://www.treblig.org   |_______/
