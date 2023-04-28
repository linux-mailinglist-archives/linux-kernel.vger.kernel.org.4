Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 950096F1E27
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Apr 2023 20:41:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346513AbjD1SlP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Apr 2023 14:41:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346506AbjD1SlN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Apr 2023 14:41:13 -0400
Received: from mx0a-00230701.pphosted.com (mx0a-00230701.pphosted.com [148.163.156.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06B0F211E;
        Fri, 28 Apr 2023 11:41:11 -0700 (PDT)
Received: from pps.filterd (m0297266.ppops.net [127.0.0.1])
        by mx0a-00230701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33SGr1gk011951;
        Fri, 28 Apr 2023 11:41:04 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=pfptdkimsnps;
 bh=mOULMazau9LsI8JR9fXgw1Dq50T28mDa3f/SV1vRbcw=;
 b=igHBZVWZ9iYIkHf7CAfwhqpGcH7Vh0ug+3dsmZIKWRSO5kfXRDcYjOUJm82VhqCaZfJM
 KVfHEnJqu5Fe8mjQNbHij7ilZXNCr/UkgBo/tTUOW0L9iHPy+H2rMiE+n9xiXg/cU/nN
 axPRZ5XsObN8RR9axiwlhO6K91N/80lzhL7MDMKCfqaGEahaCXBcA78TkR/zbbHZ3EmA
 ZPyi6USVNF+D3WDa7s6wSlmecoBsT2lLxt6G1HCRYFol4/V/gy7WE/SnYPYrr95ZLj2Y
 O7DdPMq3wYWvSwIaQ7KBXELdMJpr5tWASy1rTZaowGVEIVXi3UQa6fGs2AGjWFe2sgJ8 sQ== 
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.87.133])
        by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 3q4eu76rxm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 28 Apr 2023 11:41:04 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1682707264; bh=mOULMazau9LsI8JR9fXgw1Dq50T28mDa3f/SV1vRbcw=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=Cg+5WQZUk0MCSpBqlQor1xGxejpkkrHqEoGnU4kh0az8ybS251+U3N7a3O/IfKyVi
         TFZwHFEuIZ5QnY9BgyL8WtqVVxAib6vZgGFYUG6AyPG1vUxM81QSH2yRAyS6dD3NYG
         F6vQLlbP2n1tV6ddIWVBtzHBRCUkg6Gj58mnSIKGvx/CXTaGt+7JZTX4k0lxl4IEDU
         RCJXrKEgB5lSFvJHGSq0oOjHWBh5vhDeBF7yEbTDdumCmXSUAAFbponlcMZzTeMwxh
         ujB59w37O4Y6zsOvwTi4hEQtDLUB7a9l1CD2CI7vibvZpJ1FNryuDKShPIvQVx9FOm
         7+f8R6HEegSqQ==
Received: from mailhost.synopsys.com (us03-mailhost1.synopsys.com [10.4.17.17])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits)
         client-signature RSA-PSS (2048 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id ED6C540524;
        Fri, 28 Apr 2023 18:41:03 +0000 (UTC)
Received: from o365relay-in.synopsys.com (us03-o365relay1.synopsys.com [10.4.161.137])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
        by mailhost.synopsys.com (Postfix) with ESMTPS id 7974DA0085;
        Fri, 28 Apr 2023 18:41:02 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=mVVrcy5z;
        dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2172.outbound.protection.outlook.com [104.47.57.172])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id 7AEB64045F;
        Fri, 28 Apr 2023 18:41:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kmGHG+YGzHT/xTYGMexEjb4g+5wY0/nlXHc/aPwASFSax7BwCH1F5HDrERE1dPDCLiWis6jxtskruDRBc7lCIAq/91OypA6Q0NUZ01pXy/RHYUgAMULY0v2GjJbCYXFY9wt5qj+9MMR89laN2G09533ym0jV+kBTGt+gB4vQcPvhsKAyRvaxcb1okwhj25bV0y5cFkMdPhT4gFBvepwAZxNHJNXYw79ePFQrSIKXYC+3ykDjVycgCH/v3zs/HithBDHv9MCNxR/5m1cRY/DTAoCxI7b25zEbWjhRol1dZ+D/CIT6HAAOGjoRlVtOpyY/7/KKMJCIeb0VTVHkktoWeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mOULMazau9LsI8JR9fXgw1Dq50T28mDa3f/SV1vRbcw=;
 b=ESHYS0XZUJuIbvf7zT8mNE6ApOZi7GVzcr9uDDQGBKHKIeswna37On2USKSoktzHpbPXvDnEOoRuoo5vZ6c8YotiXC2lE491lr2BGOrxBV8oWY0XoV2IFcpPmdDAUoOpGN17xxp09HtzXdCBKXXju6pt4fI5cZQ+Tf7sQ60SZR3rRXZS05+IO+FHBXf0eYHbOh20oXqWmanB6HA1Y6itn7O+BKpIxOKUFfgpmRoEE04BJIdqbLI9DMaT3l23LpQicOOt58M1FqSaxBr6Yd7Jy1/QfjkVB8J35xGFH17dYhdqGakVEgUqvuFtPJPdm06XaGRb3YFTR+aNgazT9XTZQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mOULMazau9LsI8JR9fXgw1Dq50T28mDa3f/SV1vRbcw=;
 b=mVVrcy5zeTbL4M1e/pyUzARbJNk+oiJmAaE7cCn6SpN5grQOtCrSDnjCWABbYOL1CRasfXac4Dqw9eUBJqrKVBnm5A+k7L1YLy3CT08U71g6UzEiCOFj6egxoQGUCMQfOdW08WCLu0ajGAJCYwliOQw+z1E5z57de/muKSGzoMo=
Received: from BYAPR12MB4791.namprd12.prod.outlook.com (2603:10b6:a03:10a::12)
 by CH3PR12MB9028.namprd12.prod.outlook.com (2603:10b6:610:123::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.24; Fri, 28 Apr
 2023 18:41:00 +0000
Received: from BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::bb79:9aea:e237:688c]) by BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::bb79:9aea:e237:688c%6]) with mapi id 15.20.6340.022; Fri, 28 Apr 2023
 18:40:59 +0000
X-SNPS-Relay: synopsys.com
From:   Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To:     Roger Quadros <rogerq@kernel.org>
CC:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "r-gunasekaran@ti.com" <r-gunasekaran@ti.com>,
        "srk@ti.com" <srk@ti.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] usb: dwc3: gadget: Fix controller timeout at
 dwc3_gadget_suspend()
Thread-Topic: [PATCH] usb: dwc3: gadget: Fix controller timeout at
 dwc3_gadget_suspend()
Thread-Index: AQHZecol/Vg7TeUbx0ua98L8jPFqaa9BDlqA
Date:   Fri, 28 Apr 2023 18:40:59 +0000
Message-ID: <20230428184055.cm3lae6dmmfxgjc6@synopsys.com>
References: <20230428120812.107123-1-rogerq@kernel.org>
In-Reply-To: <20230428120812.107123-1-rogerq@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR12MB4791:EE_|CH3PR12MB9028:EE_
x-ms-office365-filtering-correlation-id: 1a69ceeb-0233-4381-4a64-08db48181c83
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KGts4HOq5sE3ChRzbqtEKex2mb2TPDFOtvrs0h1a+ZLJcwYgy46sS0/JtEF1nu0M+BpAyPuQNfkajGidtz1KyZgaa7SDSPZwCeLyNEYl4pEKQ8/QMmdtevz9UXmX69FFQdIpcq/aEDzN6X+I/xskp9ujfph8Gy4lu4RziGPE6hE5sJLEJVAdA4VSVM0XCgo1USvcS1rhZ7G8XXAnjes/QDiC/Ul/6bFPVCHTVwwqnFqm8OpLVXUUWWfbYykKiM67osAtmo2FakqzOEgQUILoRqKFWAuCipH0DLLwKx/r2qSBs6fmcz11lAd2rOcb4INnaXPzYYkXPlVd5nfKN+bNNfWZxbqwyeN0b+gHsGqKcZLrg+BpaWg/PsyCAq/oq8JnEKAjZGf1OPHoKgiYjvucUHbraimv3hKpWMxHRNINt2vGjz8MTrrdSP0AcCh0NhdAQwwcjoTOqzTZFjpOmOpdTcrC350qC6QXh4TjfEgbKBGjxSRtRmQNHdKQ8GLI33dUTTyh9aOHVryy1aBCEWQ8q6Vy0XeeSWNvUwVMxU+kA8hHiXsOAV/AaykjHW6Fje3AB6sCgIdNMrE6Z+vvrCT+/NuYe5tbGHEo9UbjYHZbqzfxqAZhRuwZvQMXrLSa4JbW
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4791.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(136003)(346002)(396003)(366004)(376002)(451199021)(86362001)(38070700005)(4744005)(36756003)(2906002)(6486002)(71200400001)(186003)(83380400001)(6506007)(26005)(6512007)(1076003)(6916009)(66476007)(4326008)(66556008)(64756008)(76116006)(66946007)(478600001)(66446008)(2616005)(316002)(38100700002)(41300700001)(122000001)(5660300002)(8676002)(8936002)(54906003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OHhqQXo2M05XQzRFVStUb3NQYzNCbU9HTDlLemJpT2pBQTFZQ0dvdFh4MStr?=
 =?utf-8?B?T2hEbnpjNTU1L3gzb2FjMzM3Z2hiaGJiaFo4Z3BIaE5kTUFEQm5RSSs2WWtN?=
 =?utf-8?B?L081VG0rMkxnQ0xFSlR2MEdyNXdyRU9ubmRiK1h5ODNLYXVKRG5Qbmp2bUdF?=
 =?utf-8?B?b1Zpd1RUaVljWllJOUs1cTVyYXRKQ3JlSFJsK0JwUld6SkFQUUcvd29BcGtE?=
 =?utf-8?B?YTg3dTdLbUdaSVA2ZkFhclhYN2hKRFdwMTdHd1BZRzBTanJ5WWFzQmx1eHRO?=
 =?utf-8?B?QWNUQWVhVlAweUZmZTI0b2VTSGNobWI4M05vNTdpYSthMzZDRlZQWitXb2di?=
 =?utf-8?B?N2JGcWVDY005SjVPSzFPN3RJeXQxRnVRVkwxcEdWWGIzOC9NVDFxaDVqZytM?=
 =?utf-8?B?cldtUlNDenJhK1pPNGNMSCtWbTM3eWR3QXpweXZDVWlycFZ1ckh0blBjWWpl?=
 =?utf-8?B?UFNQMXJnNCtqcTZwSzgwYkNmRVI5RjdRblFJQkM3eUc5K1Y4SGZsMk5EaEFS?=
 =?utf-8?B?TTBOa2RJMWpWaWNIMGx3Ni91RFhxS3RGd1YvZTE3c2hScmM1Vy9yaVJjVElz?=
 =?utf-8?B?VjV4MXd1OGlVVjNmS3ZsZi9EYzM0dE1XQW4weklSNGxxM1ZSODhZcHB6dkp6?=
 =?utf-8?B?WXNvT3k3Qk1RL2RCc3FrNTl3blpWaFhKbjEzWmNqRHQwUUw1blpJSGw1bkE4?=
 =?utf-8?B?MDRRSnk3cm8rRlZSempULzVuNnlsOFBOeGpZelVyMlJGNVlvZ0F3Z2dkYzZn?=
 =?utf-8?B?TC9icklxWFdYZW03UDRMSWRnS0lJcU10WTlYMEExZXdDUUZlL09tUjhlSitC?=
 =?utf-8?B?dUhKbUJKS2dvdFNQZDcxVmVINkRlOTBGOGZNQjVzZHlwUnU1RXNTcyszV294?=
 =?utf-8?B?TEJHV29vdnpUVkVxMTNOZ1hueHZIY3doQjByaEViSEtRTmN1eGxhT2w1UDY5?=
 =?utf-8?B?aGJsdVN2NGtFRlljNkw4WUg2NGhvZmJaYVFGd3JoUkkrN1B2dGQ4bXIxWjBZ?=
 =?utf-8?B?Y0I5ME1hVmtCRDZmSWJRd3FZOTZWYjNkVXpnNG9WSEJXR1EzVmRQL3o3WEV4?=
 =?utf-8?B?M21TTHZrZVM0Zk5QZkZBT3NNNlk0ZHVwamxXV0xMcGNyd3RvSVFzOFZ4Vk8v?=
 =?utf-8?B?Ym13am9kbnZkRHlVZys4dEpuNWZNV00ya3VrZ3FLaEtvNzNtQ3lXVXV5bnFK?=
 =?utf-8?B?MW5QVHk2VTcvQUUyd2hBNjZ4ZWs1RXJ0VlBTRW51b01YVE0xWlVFRDJETnVD?=
 =?utf-8?B?WjErcmNkTlJwQXo0VmdKemZha3RyWk1tZ0phekZ3eWljanMwSFFoajFONE1i?=
 =?utf-8?B?WGZZUmw4ZjBpeE81eVpvNmVLY1oxV1Rub3JOUFN0cnozRnJRS21vd3dEbzlM?=
 =?utf-8?B?NWwrTEZjT2c3ZkNpdmxPSTRKSW1RS24wRUxjalZRVElFRmkwSktJYTFDWjVS?=
 =?utf-8?B?OGtKVFc0SXFTRzZTYVJDWGdJdWdEUmFTbXN4czBXT2RKSmcxeXZXY1ZUSjN3?=
 =?utf-8?B?TFZrRVpXM2dRMjFMT1NEV0tkZ0UzR0x4cGljU0tOdS90MDcySHBQWFFhNHVQ?=
 =?utf-8?B?a2p2eXp1T0hDZm45T2d3VG8rL1RTVlZ1dnZYdHA2Z0srZEFhOVVzOVQ1bVcy?=
 =?utf-8?B?KzRYUTN0ZmJ2aWNiaStUOUdnd3h1ZzN1bFgwNElCMzJ3ZmhlTEdKQ2JaY2lz?=
 =?utf-8?B?aytYRkQ1ZXdUV3Rud2I3R0lMRlZ0eWVNVnI1c1ArVi90MGhWT1VaQU1JbUpk?=
 =?utf-8?B?NkZvZ21YZy91QjlaZmhxVVlIaUN2QjNSSFJzUzlUQytJUFZ0Z0dzQ1k5VnhV?=
 =?utf-8?B?eVFiZ3NNRnJsQ1B5aVRqVEw4SFFyc1pGRVZmRFJsUCtpL3kvK0hvQzF1Vmpu?=
 =?utf-8?B?SjJOaHFuR1dYcVFOWWF6TC95ZVFQYjhwNXBQcG1VYTVwdldHaEN1SERpa3pQ?=
 =?utf-8?B?VmowQnZDSlZPV0VMMDdqc3R3eFdMZkl0Y3VLcFVva2M5OVhDSnNNaGlVL0lm?=
 =?utf-8?B?Z2g4b0RySlNnclJrSm1RR05LZmkwQjN2eU5sLzN4VExJY2ZPcDhmcXAxMmVo?=
 =?utf-8?B?KzFNak4wMFFsUUFhNldzbk1ITFc3QmtYM0xrZFA3OE5PUGtZYkV1Qk50TmhS?=
 =?utf-8?Q?kX2CnbANtWcvd2vUuSOfPT9Ej?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <82D850B4A6A9C74C9319CF205D53AADF@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: Wp9T3jQ2Qj7kqAel3xRE0CmVNOlj5N7JA6M59Lr4Uty0Kn8WHUUyl8mPxvRYG7L5Cv/qdZ1KXYbhYbiBjblRPWB7tL99g1xnYdgbxYndYWxAqAQrG/2bS6pQe2PxjjOsa947AS97I4ZPGUeFuB8ko005eNnQeyW+N103OtEbPh694GoUMHHgL6l3u3ZO/6VN6EtiK66qC4e4PtQgkmeEHkWwOs/1JpDgKXnz+xb1ARPhM4SLhevtwnEAO0hDr3t7CKHktTgI5/bfuFea7C3niTZJIgyoeu3dH74JqEGr95Qyp6Dg/AmyZ4xvloH5dQ0E3iNKdtMBU3S+yFdzT3xJq7r9Xr9GnF372RpVYCOsTz4vjnPx+IZb1iYOiV91/u7CIUkCOsARjAGqQWZQI9oPZjPkMitSZeHEyDfDycgCK2dAYX86I+iJAfOiytrX/RtEzDicZUE+murOkPx3XoK0X12KdDE8nXgRErDMdomSRm0AR7IaqYLPE/97HltDWYPI+IsJ4WQFvFjlLQGuxuTbILaVdA3Kkz630gK0rADIZlQUrt+T3ig63CAVuoJQWkfBCv8pCS5I9t4Kbchc5S4SGlPpUV6AHao52SX97yPkYbahP2Vfjc7K1JOURCgMuFeazyDZi3yr20JT6pq+kJeG9BQ9/hwoxu6cd0JglQAhewGlEhWKY+yIbtOcsmkz7nGQBUoRbHxYZq6QJcReWw5WiLkRZ0L1htBa90+QuSqbV0+n99GOZw3C31M/n+2WKXebaxW1/govOk3E6bQOYxgtyOxKWtTdG0oDYxGfPf1fUPVTdEx38MNMIlJdxcDdhE0V0xUxh+nYxqTaD2dlm/+WIMhr6syKKBB5+g65CjIvF1YeVELmsmdFjNcPvyEXdsTnm4TDLLf0mLdTRjxxvKbgmQ==
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4791.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a69ceeb-0233-4381-4a64-08db48181c83
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Apr 2023 18:40:59.7343
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 316IDQJt5QUIOulLmhV8NhS1oRj3FWc9m6hjmrJ1PtdkV9nRn2hCb1iZ84mompQk4DDcX0ELhh3ZLd8XxV7djQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9028
X-Proofpoint-GUID: h42Nyh5OWlE1M6yqoonzfm47RybTGSeh
X-Proofpoint-ORIG-GUID: h42Nyh5OWlE1M6yqoonzfm47RybTGSeh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-28_05,2023-04-27_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 priorityscore=1501 bulkscore=0 adultscore=0 clxscore=1011 spamscore=0
 mlxscore=0 phishscore=0 mlxlogscore=338 malwarescore=0 lowpriorityscore=0
 impostorscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2303200000 definitions=main-2304280151
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gRnJpLCBBcHIgMjgsIDIwMjMsIFJvZ2VyIFF1YWRyb3Mgd3JvdGU6DQo+IElmIGdhZGdldCBk
cml2ZXIgaXMgbG9hZGVkIGFuZCB3ZSBhcmUgY29ubmVjdGVkIHRvIGEgVVNCIGhvc3QsDQo+IGFs
bCB0cmFuc2ZlcnMgbXVzdCBiZSBzdG9wcGVkIGJlZm9yZSBzdG9wcGluZyB0aGUgY29udHJvbGxl
ciBlbHNlDQo+IHdlIHdpbGwgbm90IGdldCBhIGNsZWFuIHN0b3AgaS5lLiBkd2MzX2dhZGdldF9y
dW5fc3RvcCgpIHdpbGwgdGFrZQ0KPiBzZXZlcmFsIHNlY29uZHMgdG8gY29tcGxldGUgYW5kIHdp
bGwgcmV0dXJuIC1FVElNRURPVVQuIEZpeCB0aGlzLg0KPiANCj4gTm8gbmVlZCB0byBzdG9wIHRo
ZSBjb250cm9sbGVyIGF0IGR3YzNfZ2FkZ2V0X3N1c3BlbmQoKSBpZg0KPiBkd2MtPnNvZnRjb25u
ZWN0IGlzIDAgYXMgY29udHJvbGxlciBpcyBhbHJlYWR5IHN0b3BwZWQuDQo+IA0KPiBIYW5kbGUg
ZXJyb3IgY2FzZXMgcHJvcGVybHkgaW4gZHdjM19nYWRnZXRfc3VzcGVuZCgpLg0KDQpXZSBhbHNv
IGZpeCB0aGUgZHdjM19nYWRnZXRfcmVzdW1lKCkgaW4gdGhpcyBjaGFuZ2UuIEVpdGhlciBjcmVh
dGUgYQ0Kc2VwYXJhdGUgY2hhbmdlIG9yIG5vdGUgaXQgaW4gdGhlICRzdWJqZWN0IGFuZCBjb21t
aXQgbWVzc2FnZS4NCg0KPiANCj4gU3VnZ2VzdGVkLWJ5OiBUaGluaCBOZ3V5ZW4gPFRoaW5oLk5n
dXllbkBzeW5vcHN5cy5jb20+DQo+IFNpZ25lZC1vZmYtYnk6IFJvZ2VyIFF1YWRyb3MgPHJvZ2Vy
cUBrZXJuZWwub3JnPg0KDQpQZXJoYXBzIHRoaXMgbmVlZHMgYSBmaXhlcyB0YWc/IChFdmVuIHRo
b3VnaCBpdCBjYW4ndCBiZSBiYWNrcG9ydGVkDQpjbGVhbmx5IHdpdGhvdXQgc29tZSBtb2RpZmlj
YXRpb25zKQ0KDQpBbHNvLCBwbGVhc2UgcmViYXNlIHlvdXIgY2hhbmdlIHRvIEdyZWcncyB1c2It
bmV4dC4NCg0KVGhhbmtzIQ0KVGhpbmg=
