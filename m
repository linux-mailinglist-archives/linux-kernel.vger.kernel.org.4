Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C5896BC24C
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 01:17:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232481AbjCPARJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 20:17:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230209AbjCPARF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 20:17:05 -0400
Received: from mx0b-00230701.pphosted.com (mx0b-00230701.pphosted.com [148.163.158.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3282E76156;
        Wed, 15 Mar 2023 17:17:00 -0700 (PDT)
Received: from pps.filterd (m0297265.ppops.net [127.0.0.1])
        by mx0a-00230701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32FMZMlq003550;
        Wed, 15 Mar 2023 17:16:53 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=pfptdkimsnps;
 bh=csxgOPykH68FoYzUODUL+eUWOpA3wNTO7qmyIOvY0O0=;
 b=BDvGDJhPOVj3Q1odaV7ieJlv8sGKVdwtyOIetOGo+NtT+gsmAe6MPI3Ico96+kFMjwhh
 il84hbTL4k5QXB7vqA8DXc169+ypWGpWGATkbZUipRCFvPbp5DmCYgyg8uFILTGmTVVw
 BZyUw6+0thuOv7QXzaegKrbtFBotbBGncoBAnVAy++v9vg/9jB5qtzUjRNW3tdDP5L0S
 qsdkZ1j1f8lwFy6Qx+GvW4iVt8Yn73clkDMF/99fyrLhhSnaz39btErEIbDYkAcXJK5m
 omMl/JshwuWXOAygMAWBHDqicqZO6eUKD0dklZYzCDktLx1EkiPIdD4Qwkd4lcZs58vT KQ== 
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.73.133])
        by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 3pbpxt0a1q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 15 Mar 2023 17:16:52 -0700
Received: from mailhost.synopsys.com (us03-mailhost1.synopsys.com [10.4.17.17])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 1901040083;
        Thu, 16 Mar 2023 00:16:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1678925812; bh=csxgOPykH68FoYzUODUL+eUWOpA3wNTO7qmyIOvY0O0=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=d07T53hvWjA3Ao9hHPk1hyAtPBKEuoFs4sr1XeK1Hhi43o5VCG7mkZ0n9bkAYlAaO
         eP90YL480kEOAAXRJqZFzaALVRLF6nxHPY+1ymKC7cctPA+BYs7BF0GiQO4/EINoc9
         6OC1NdyvyacOmo5tjDz+3sWRejdh2AAW8zobJRRSj2jnPCAsMvAKl9QJGDLAIMlJA7
         MvxC1u/UOz/vnZvgwqfON0h6wKTVMvgMsbX5SoFu4mF7T4j6J6GFC5Mjk3brTYcFsA
         jL0J0gOm4udhQI1y63txY+S9JQJf7ZToPTF3RmO1uGINsSitPQ52YHB0WTcoMqd/wk
         ZI5jcfn2nvO4A==
Received: from o365relay-in.synopsys.com (unknown [10.202.1.139])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
        by mailhost.synopsys.com (Postfix) with ESMTPS id 9438AA005C;
        Thu, 16 Mar 2023 00:16:50 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id CCCB34006B;
        Thu, 16 Mar 2023 00:16:49 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=thinhn@synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.b="tu72vIPc";
        dkim-atps=neutral
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ttv7Yp0LtVRBy+xwoTYxdrZrl/of8KsYnMvWqy9GC072U5qEgxUzrN6EKCP87tgX5OVKZ6A1JsVOFEwsUYsL8yL+inrApiukwbRpoEjsnfAlI8wbWNg8rM/AG7Q4UnpFiZ3GqqscGYsr3ws7UfqZJCaNLH9SFkmMV0/iyHEJZeG9I7Bh5Dz0FWnCpYCmoV94wviq2FF7DsDOhyp7qbNA6FXHAnoeTrxQ3Iie4b8fPWSVoZQH5ZL9uuAyhV4d/JBm9yZZdAxh6VnXIgnuaqpF67NKKCjms+nEeG4lO5GUbe85GwSv8tLka6YEAxvWTmQdAsPMJKzgGBSMyyrEvWjIKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=csxgOPykH68FoYzUODUL+eUWOpA3wNTO7qmyIOvY0O0=;
 b=C0w9ZrRwIafsSxwPaqGoHIgkZVxyfGrBBIyCZqUNt58PiZ4oSgX1QOnDBX/pziydqm7Z9EKO2ZMtt9ZXx+GUQlCm4hg8Rfec8ZalnTpyaRSdmT0B2zu9ea+S12LIYWGqZ+AYtKXKy4uk4LFxXsISACLMMP8jTThGW4XxdqUf0hfsT5K0tIpSIUeQ4wuyndZUwO0Q258rlQ4BOGa8DfcVf7n3x0KUFuaUHWmdRb5TdTfI6KU9vIJDkAYGxEH+RDdPkEejOK64/UpL8/vEBza8OAdcWIH3Zb2suC64I1189G8P35QgOPufDYGkGoVV83avtzy+Cddx8LZDQ3D+JyfK4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=csxgOPykH68FoYzUODUL+eUWOpA3wNTO7qmyIOvY0O0=;
 b=tu72vIPcyZ/tKTYfwaUFMXU2iCBa7m4YsWMMwRvOVDL6ChSNlin2Fvz/b7fc0UXU/Adz+WsPyZJig8vRvcsa5LeSnq5QoRt6yt+UeXr3akcuV6DLOJ4XRhc4a0smIy3yD7m2IKdKn81/ZVvQgtjytC+UxtpjX2MvskqOF7LcT1M=
Received: from BYAPR12MB4791.namprd12.prod.outlook.com (2603:10b6:a03:10a::12)
 by DM4PR12MB6037.namprd12.prod.outlook.com (2603:10b6:8:b0::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.29; Thu, 16 Mar
 2023 00:16:47 +0000
Received: from BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::3161:c44d:8bb3:423f]) by BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::3161:c44d:8bb3:423f%3]) with mapi id 15.20.6178.026; Thu, 16 Mar 2023
 00:16:47 +0000
X-SNPS-Relay: synopsys.com
From:   Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To:     Elson Roy Serrao <quic_eserrao@quicinc.com>
CC:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        "balbi@kernel.org" <balbi@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "quic_wcheng@quicinc.com" <quic_wcheng@quicinc.com>,
        "quic_jackp@quicinc.com" <quic_jackp@quicinc.com>
Subject: Re: [PATCH v11 5/5] usb: gadget: f_ecm: Add suspend/resume and remote
 wakeup support
Thread-Topic: [PATCH v11 5/5] usb: gadget: f_ecm: Add suspend/resume and
 remote wakeup support
Thread-Index: AQHZV5qLRqyBLfxv1k+vCgv7hf6LEa78ifEA
Date:   Thu, 16 Mar 2023 00:16:47 +0000
Message-ID: <20230316001638.x2kviqutn6xkyaea@synopsys.com>
References: <1678924913-9364-1-git-send-email-quic_eserrao@quicinc.com>
 <1678924913-9364-6-git-send-email-quic_eserrao@quicinc.com>
In-Reply-To: <1678924913-9364-6-git-send-email-quic_eserrao@quicinc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR12MB4791:EE_|DM4PR12MB6037:EE_
x-ms-office365-filtering-correlation-id: aa8435df-5d3c-46a6-d0b5-08db25b3bb55
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: CnPczGgcxDCyKTSGnmRz7LxIh+p85mTgzCCXkua461hOGdHrXuSQB5uhPZ/Ge+E7JeWZjYFJJcF7QpGo8C65pMq/O8xiH70nwohXXVKYWV/SE3kcqqweyuLpB7m85DKXNw+DHzes4BCuALXZd+WDE5vFzHs0/L6sTLB48JKyVkdzWSSpkEkb4kzvdLz2lHXLJAt+PZ+/hVRzvymItflyaN1vKiuF86oFWi2eTB3qs4XSAgVM0eofpt9mkPGqcLFadvyF4B1tAWXmaLh4NZvKGT6FJrTZSojRRhNp3b5OnSiIYmGCAgmNnYBOiBj7NLkmB3dOhleIRcaBcgsXo/1V0J9H6x2JcWd9ZwgIeekMcbeiFGNF5kbShSgOcXEvaxhBE48AFYV7lsDRS734ReJv521iTebSHOaRKeNDtLg73dELEihzX++L4Cc6kgFiAVTSMlAssXRWch2JzGeCBwhAulurCP2ZvfrDLVsSl+E+IuFJjZoh3vHNWOJD1liNhVHry8PtP+crrcPQCwSMCx5FrcObjhsHM3oSaJbYh+UuxtQgniHCRANty3ll9bqiIJiV9MEvvuc2ZQ9OFdjdy7UyooIfdghF6Rc1CspE2sGsH3n9CkLYvg4+ORl1tShniq7B/6aa2uHdnwcFWMVmu5rb9ZtC2bkXF4YdxAVQWPElm7K2oGUn+MjIvkr/NE3vohT4lN6sv7Jewu64EXj1aB3+zg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4791.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(39860400002)(136003)(366004)(396003)(376002)(346002)(451199018)(122000001)(15650500001)(2906002)(41300700001)(83380400001)(66476007)(36756003)(5660300002)(54906003)(8676002)(8936002)(4326008)(66556008)(64756008)(6916009)(76116006)(38070700005)(38100700002)(86362001)(316002)(186003)(66446008)(478600001)(6512007)(66946007)(1076003)(71200400001)(6486002)(2616005)(26005)(6506007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VW9zTlFoYnBsK3ZpclNubjRDTndnNHVPbEs5TnFpVU5DVjhLaWVIazFUdVlN?=
 =?utf-8?B?Z0p1UFN2eS93dkswaTBxVWl0TmFlblJoSWNHelZkR2ZmUExKdmJNOWNpSkUv?=
 =?utf-8?B?Y29jUU0wYzZ5UXNBRmxPNnF1Tlc2OXphc2FZQVdibDVqNkJpSyt4OWd6cVA4?=
 =?utf-8?B?a3NZa0ZJaCtSRTV1dFhZWG16bjBWd1NMOEt3cDhKdU1OMGFodmhBVHFZeE4r?=
 =?utf-8?B?NzJacWVGQTR3cmNhaGRGMGQwMmhLeHF5Z3VoM1NnMXVBM1ZjRHFERTU5c0tI?=
 =?utf-8?B?UXdrQU5yWWtNTmpRaTNycU5SaVhuQ2hwMTJ5NXJqUklWR0JFT2hxY0EyQmtk?=
 =?utf-8?B?QXNvL1hLcnoyeW9vWEozTzZVQ01RTnBEN0UwdS9aVTV3VHlmZDRoSlJOK3l5?=
 =?utf-8?B?U1FWL1ZSVld4emhoNnl2TDZ0SDJyNkQzeHNCeWpoUFdrNmhTSmFZNVViMnY3?=
 =?utf-8?B?TitIRnE4T2tqWXlReFE2U29XaWhtek1pZlExbUo5aEtRdzJSWXhEYWtLNGUv?=
 =?utf-8?B?eC9UcmdoR21zWnh6WmpLM2hvT3Q4emdsQlUxMTJtb1hsektzZmxXSkNiT2Ns?=
 =?utf-8?B?UWZMMlozWktNakY4Si9ndWJNZHZEeEZEeFIrWjRRYTBHeHBwL3dNaU03NFFZ?=
 =?utf-8?B?WS9aa01NVnB5dGpGRHJ0Y0RveFJLS25QZWI2bkZheWZoSlk4bmFlaFp3MEF5?=
 =?utf-8?B?ckpJa2UyVkNxZS9uUmxDWnB4cEpmNUp3eTRMRFNDSHVubXJTNVFlU3pVS3I4?=
 =?utf-8?B?U1BtRU1Ga1VISkdLWWQ5YUVCaEE4R2N1WG5ZQ0xqRjZUbFg1QlBndUJPTzd1?=
 =?utf-8?B?cU5Ga05rbytaclpzRk8vUlR4a3ZlRTRpUGUvc1ZVQ0Q4aFRJZFZCVWo0RDZT?=
 =?utf-8?B?RUFhNGV0M2NYeXZmMEpDR1J2VmJ1MHc1Y1pzQncwalBJMlNZb1JxUVFuV2t2?=
 =?utf-8?B?cWU4T01abE50RXpwMG9ET0V0eUx6OW0vWUV1ZFZwbElpVTNPRHlRb1REVW9J?=
 =?utf-8?B?S0lWOTQzM1ZGUCtoVWUyUnJsMUZWM2pabTNKbVU0SmhXZzVQb0ZKM08vR0t0?=
 =?utf-8?B?RXNwbHBsWFIvY1kvVlVUOStlVTlLYmlDK1NVQk8rNDZxMHFUM2VjMXhTTWlR?=
 =?utf-8?B?RFpVMnZOTER1MFZPOUJ6YzFKRlBmMHc2d1JkeWZ3c3hBSlBrN3c5cVN3WVI4?=
 =?utf-8?B?U2E2cUMyVzRIeTVaRit6aGhFQnh1R3hJQkdWcUhJYUdGM2oveEZRL0FLMU1r?=
 =?utf-8?B?dDhRd2wzWnR5UTRzYnNLTTJmdXZVUmFDQUFKTVIxN25kSmMxVkdHcEVnQ1pv?=
 =?utf-8?B?d2hMUENNdjZHRUZzVitRQ3NyMEJEUzJ3NHJTSFdGZUVPUW5ReWk5VFRMWFdD?=
 =?utf-8?B?OVgzTjNta2ZPRDVKNWFxaHo1QWdRU2RrVFJGL2tEQkJlamZJTnByb0JCaVpG?=
 =?utf-8?B?R1pCcUdOSmgybjFPdTVvRm5nR3RFVDZhZU10ZDNlQllzbGtDWS9ncFVreVo1?=
 =?utf-8?B?YzhKek16ckFrQis1Q1docXN6dTlBeFMrV1ViQkNCc3VRMXJYYkNLcTFkZmVX?=
 =?utf-8?B?aHFQdCtuR1RManVyaHUrU0hMWFkySFFrWFU2NTFTdmc1RHhNenp0dmNPS1RQ?=
 =?utf-8?B?eXkxN2JBQjR0WEhraGt3YVlLTWtxQ2dKWDJTSE1LbTVYSlliRWRJL1U5K1A2?=
 =?utf-8?B?dkp4b2txdEROWHFsZVRjdkNoK0pTZTI0TzVtdG9DTG1MaVN2dWkrMnRqN1Q1?=
 =?utf-8?B?SU4veHJscWNKMURTVlJhY3ZZeTIzMEVFQmtCOVNKM29jbzQrYjlCLzB6bHFY?=
 =?utf-8?B?STNWM3hhVUhIbWJkckt2N05UNHJCa0x3Q3BqN01Kak1qMVFUSitadUJHalZN?=
 =?utf-8?B?NzdtRHpzcHZLTVRrOXRwcVA5UXVUMzBBbjFYMVZhakh4S0hicUdKRnoyYnJI?=
 =?utf-8?B?M1BHUzVyc1B1S3JNSGtYSXpnNEVZM2dkb0hoamhoOUhLaWNtWDlabUtRdGJN?=
 =?utf-8?B?eFdhV3dqa0JqSE9BSEhnK1F0ZWdPQXhtMkZncTZqY21nejBLWXBsdWxqWEdS?=
 =?utf-8?B?TmNyT1UwaTJvSVBlMXZGMmxQQllkd1doRDBZdmtaYmtiQWE1c2Jpa0JrQ25E?=
 =?utf-8?B?NjQxZ2dTWlNhNUtNN2UyQlpzV1gwb2JMOHFCbEV1SnNacGZtbThGUTJHMDBE?=
 =?utf-8?B?bFE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <CE08F1012BC33B449F36ADD64D1C274A@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: lGtO3Y2QBqMnNtmEB+TZlf3csI2D2E7HRnjXeO5eB4emI2f1zRJVq6RfGntEAFyB3+I2kIXBwOTte/h+VCZQgeCUpy87N1EmObVBpCAAt+mjK1wfnyeUpnBwjMcy4G1cleEQlJf+Ba3k283aRO+DwGg9+g+QOt35z3ecdxkY0WSaA+vDzHnDW9NdwIWnAgo0du8ZZACNknVZ9lbBW/CeKiM3veKfClUyulKDVL3ALcyJt7/247sZxjHLc50/zXm5qG4qEpZhSq5E+dD0K3Bt+tBc7JnIDYw7kp/eOWmXOVSQIEUQPmwFG/vBcZnS95/zgR5F5GgrEOn8GXh62agu9ts7JU0ntanBr0XMzVNi4KElYW803zA6ew8WmzzG8kdEsJzfKO181CR8nTxLc792QXHpnjitnPOJGSkQ+ICSk6R1wDK303BmBSQLapMCwRaFy4bS8WBcwttLofup4niJYvNXastC4IXVANlrZ2B3mHHu6J4sWq2jUUrZK6DE1BbrDotTUjjMnvXh0lXONobnTtyk3H5x/YEGojkJjpVRRWgoPNpBFUQtX1QcSOh+mqMY/SdtqxEerK0i9MDIkxFh98i4q2YQPpK5pDN92hvHxrKf3EdxtmABizgV2GSOWhDRsvuW2bUC9rhiQ9K0UyX9x64pRGW72fhMylARxLLLSJ2CgwJp8DwYGaZ7wmjlXQFPIzby7q+ukoGRP+Tumrk8fqIWK36kkB59SCM4FEGhEBMo7Oa6IBN8swmLnU1xLp+YN2Q68GblD0KP6c0/0hRRHmfX174FwUC37EjlToGCf6dqMNcgDu7BHRqsVNhWmQSqO4hZ99CpXtnW3r2Jf7SHTCyVyfqo6k1qssupjmQe5olqE46N1B3Db2pOmwocd9fZJ8YIy3Ocm2Of69FNzUVA82XL3Toc3ygbfDcn3vV8hzo=
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4791.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa8435df-5d3c-46a6-d0b5-08db25b3bb55
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Mar 2023 00:16:47.4925
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vmGJpfJZTi+yA154F1wVSvPhNoYNZx1CDTxX2IP56mNn8EreEGfXNrBxpGYaFHKUs1+zh0uyRA4GC+qDF5Xpjw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6037
X-Proofpoint-GUID: P9NnGZ9F948uIODrmheS0QPcuE0duSsa
X-Proofpoint-ORIG-GUID: P9NnGZ9F948uIODrmheS0QPcuE0duSsa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-15_12,2023-03-15_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 impostorscore=0 phishscore=0 mlxlogscore=947 suspectscore=0 bulkscore=0
 lowpriorityscore=0 malwarescore=0 mlxscore=0 spamscore=0 clxscore=1015
 adultscore=0 priorityscore=1501 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2303150002 definitions=main-2303160000
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCBNYXIgMTUsIDIwMjMsIEVsc29uIFJveSBTZXJyYW8gd3JvdGU6DQo+IFdoZW4gaG9z
dCBzZW5kcyBhIHN1c3BlbmQgbm90aWZpY2F0aW9uIHRvIHRoZSBkZXZpY2UsIGhhbmRsZQ0KPiB0
aGUgc3VzcGVuZCBjYWxsYmFja3MgaW4gdGhlIGZ1bmN0aW9uIGRyaXZlci4gRW5oYW5jZWQgc3Vw
ZXINCj4gc3BlZWQgZGV2aWNlcyBjYW4gc3VwcG9ydCBmdW5jdGlvbiBzdXNwZW5kIGZlYXR1cmUg
dG8gcHV0IHRoZQ0KPiBmdW5jdGlvbiBpbiBzdXNwZW5kIHN0YXRlLiBIYW5kbGUgZnVuY3Rpb24g
c3VzcGVuZCBjYWxsYmFjay4NCj4gDQo+IERlcGVuZGluZyBvbiB0aGUgcmVtb3RlIHdha2V1cCBj
YXBhYmlsaXR5IHRoZSBkZXZpY2UgY2FuIGVpdGhlcg0KPiB0cmlnZ2VyIGEgcmVtb3RlIHdha2V1
cCBvciB3YWl0IGZvciB0aGUgaG9zdCBpbml0aWF0ZWQgcmVzdW1lIHRvDQo+IHN0YXJ0IGRhdGEg
dHJhbnNmZXIgYWdhaW4uDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBFbHNvbiBSb3kgU2VycmFvIDxx
dWljX2VzZXJyYW9AcXVpY2luYy5jb20+DQo+IC0tLQ0KPiAgZHJpdmVycy91c2IvZ2FkZ2V0L2Z1
bmN0aW9uL2ZfZWNtLmMgICB8IDgwICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
DQo+ICBkcml2ZXJzL3VzYi9nYWRnZXQvZnVuY3Rpb24vdV9ldGhlci5jIHwgNjMgKysrKysrKysr
KysrKysrKysrKysrKysrKysrDQo+ICBkcml2ZXJzL3VzYi9nYWRnZXQvZnVuY3Rpb24vdV9ldGhl
ci5oIHwgIDQgKysNCj4gIDMgZmlsZXMgY2hhbmdlZCwgMTQ3IGluc2VydGlvbnMoKykNCj4gDQo+
IGRpZmYgLS1naXQgYS9kcml2ZXJzL3VzYi9nYWRnZXQvZnVuY3Rpb24vZl9lY20uYyBiL2RyaXZl
cnMvdXNiL2dhZGdldC9mdW5jdGlvbi9mX2VjbS5jDQo+IGluZGV4IGE3YWIzMGUuLmQwZTMwZTgg
MTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvdXNiL2dhZGdldC9mdW5jdGlvbi9mX2VjbS5jDQo+ICsr
KyBiL2RyaXZlcnMvdXNiL2dhZGdldC9mdW5jdGlvbi9mX2VjbS5jDQo+IEBAIC02MzMsNiArNjMz
LDggQEAgc3RhdGljIHZvaWQgZWNtX2Rpc2FibGUoc3RydWN0IHVzYl9mdW5jdGlvbiAqZikNCj4g
IA0KPiAgCXVzYl9lcF9kaXNhYmxlKGVjbS0+bm90aWZ5KTsNCj4gIAllY20tPm5vdGlmeS0+ZGVz
YyA9IE5VTEw7DQo+ICsJZi0+ZnVuY19zdXNwZW5kZWQgPSBmYWxzZTsNCj4gKwlmLT5mdW5jX3dh
a2V1cF9hcm1lZCA9IGZhbHNlOw0KPiAgfQ0KPiAgDQo+ICAvKi0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0qLw0K
PiBAQCAtODg1LDYgKzg4Nyw4MCBAQCBzdGF0aWMgc3RydWN0IHVzYl9mdW5jdGlvbl9pbnN0YW5j
ZSAqZWNtX2FsbG9jX2luc3Qodm9pZCkNCj4gIAlyZXR1cm4gJm9wdHMtPmZ1bmNfaW5zdDsNCj4g
IH0NCj4gIA0KPiArc3RhdGljIHZvaWQgZWNtX3N1c3BlbmQoc3RydWN0IHVzYl9mdW5jdGlvbiAq
ZikNCj4gK3sNCj4gKwlzdHJ1Y3QgZl9lY20gKmVjbSA9IGZ1bmNfdG9fZWNtKGYpOw0KPiArCXN0
cnVjdCB1c2JfY29tcG9zaXRlX2RldiAqY2RldiA9IGVjbS0+cG9ydC5mdW5jLmNvbmZpZy0+Y2Rl
djsNCj4gKw0KPiArCWlmIChmLT5mdW5jX3N1c3BlbmRlZCkgew0KPiArCQlEQkcoY2RldiwgIkZ1
bmN0aW9uIGFscmVhZHkgc3VzcGVuZGVkXG4iKTsNCj4gKwkJcmV0dXJuOw0KPiArCX0NCj4gKw0K
PiArCURCRyhjZGV2LCAiRUNNIFN1c3BlbmRcbiIpOw0KPiArDQo+ICsJZ2V0aGVyX3N1c3BlbmQo
JmVjbS0+cG9ydCk7DQo+ICt9DQo+ICsNCj4gK3N0YXRpYyB2b2lkIGVjbV9yZXN1bWUoc3RydWN0
IHVzYl9mdW5jdGlvbiAqZikNCj4gK3sNCj4gKwlzdHJ1Y3QgZl9lY20gKmVjbSA9IGZ1bmNfdG9f
ZWNtKGYpOw0KPiArCXN0cnVjdCB1c2JfY29tcG9zaXRlX2RldiAqY2RldiA9IGVjbS0+cG9ydC5m
dW5jLmNvbmZpZy0+Y2RldjsNCj4gKw0KPiArCS8qDQo+ICsJICogSWYgdGhlIGZ1bmN0aW9uIGlz
IGluIFVTQjMgRnVuY3Rpb24gU3VzcGVuZCBzdGF0ZSwgcmVzdW1lIGlzDQo+ICsJICogY2FuY2Vs
ZWQuIEluIHRoaXMgY2FzZSByZXN1bWUgaXMgZG9uZSBieSBhIEZ1bmN0aW9uIFJlc3VtZSByZXF1
ZXN0Lg0KPiArCSAqLw0KPiArCWlmIChmLT5mdW5jX3N1c3BlbmRlZCkNCj4gKwkJcmV0dXJuOw0K
PiArDQo+ICsJREJHKGNkZXYsICJFQ00gUmVzdW1lXG4iKTsNCj4gKw0KPiArCWdldGhlcl9yZXN1
bWUoJmVjbS0+cG9ydCk7DQo+ICt9DQo+ICsNCj4gK3N0YXRpYyBpbnQgZWNtX2dldF9zdGF0dXMo
c3RydWN0IHVzYl9mdW5jdGlvbiAqZikNCj4gK3sNCg0KQXMgZGlzY3VzcywgaGFuZGxlIHRoZSBn
ZXQgc3RhdHVzIGZvciByZW1vdGUgd2FrZXVwIGluIGNvbXBvc2l0ZS5jIGFsc28uDQoNClRoYW5r
cywNClRoaW5o
