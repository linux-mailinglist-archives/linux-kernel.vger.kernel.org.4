Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE4CD6EFB74
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 22:01:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235121AbjDZUBx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 16:01:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233315AbjDZUBv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 16:01:51 -0400
Received: from mx0a-00230701.pphosted.com (mx0a-00230701.pphosted.com [148.163.156.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FB8BD2;
        Wed, 26 Apr 2023 13:01:50 -0700 (PDT)
Received: from pps.filterd (m0297266.ppops.net [127.0.0.1])
        by mx0a-00230701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33QFLtRb025356;
        Wed, 26 Apr 2023 13:01:45 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=pfptdkimsnps;
 bh=Cro9fBXYbze5UzjCDsZOrXirBb0DHVoMdnrHGCHFw10=;
 b=DpFa/NIAC+rTHejSA+RzmUg/DEvJlKbi12pkHkoJKQr8tZNerZPqV2xOrGgk1kLdFiu0
 1fPDYX7tX5jzBnVVKgje5Al8fhGHuOz5h8RsoVloyGEGvMuYM2hVbRENu7WkAleK3NPh
 PFHhvmcOspS8bPILJtKN5KZ/8vVuP2Svpiw9WPJAs6kjKv2hxBpg/0UsO3acnVsEyq02
 PEaSdYbnniPwEngXzHB56+vKSKXKoZYxUVpwDoQ+Vi6fUHwEzmNZElRA8tSTuAN7nl9k
 TbEzABMaI2+Nxn5Or51fDWiULQ3Lu3E09CfnlRabRbF1NpwgVGFWkDdx7YtrPHu8Uodr Bw== 
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.73.133])
        by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 3q4eu6uegg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 26 Apr 2023 13:01:45 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1682539304; bh=Cro9fBXYbze5UzjCDsZOrXirBb0DHVoMdnrHGCHFw10=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=KiBXgsJDZTsdwnms5nq97extyNAMkjkxgyaiS3gwBrp1Ggpixt321Rxhz+nuPU+oB
         YqqaHhiBiXRIk+902adUstrSMaKGcIaxvy3EiAE5SnNCe1YiOz070x/WWu+6bqKRco
         RxoKc8xivHROANRFn2aa2mWLH4Y6lI92IyGfROfkFPywrWC2P5B4YqtBe35G6yfOrg
         6IE417t4iqgQp0O7qiXEgUKy4L2XrIKTrFhgAAJu0sT5bAQGsgCMj7pXYCN8Iu2/P9
         ifvwVW/KJiBwRSTNBd6LTJKDnkku8TS65kKk7H8gfQG4nl8tZyX7tD0liraLNnNIMS
         c2Cc8XMPvD/dQ==
Received: from mailhost.synopsys.com (badc-mailhost3.synopsys.com [10.192.0.81])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits)
         client-signature RSA-PSS (2048 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 5C6EF4075A;
        Wed, 26 Apr 2023 20:01:44 +0000 (UTC)
Received: from o365relay-in.synopsys.com (unknown [10.202.1.139])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
        by mailhost.synopsys.com (Postfix) with ESMTPS id EEA79A007A;
        Wed, 26 Apr 2023 20:01:43 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=pI3Ir4Sg;
        dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2176.outbound.protection.outlook.com [104.47.55.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id 802404045D;
        Wed, 26 Apr 2023 20:01:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q8D//wC7yETxZSJudkQ9KGGKAbnMZOroMnUCQ6KZ4EQLWyOtH62BkQq7xXnw/Wte/2v6ah0Lqr12NquhFmYzcsbopHEd/Iclbu29rGTdZ8Lslt4HKxjXFM9H7iNPuB37yQG1BhYP8Mzi43hkAQLPVd//MmOia5enhpWRXCnYtP935Yv9u0iGU6aT2fMoUkjzb7j5FvY4o0isJvm0DoZR5q7d0r7qwxx/pfaMRoQhMbTQ5iMCBx2yW+h/tX16kPHr5MKlsuPRKaPjsJkHxnSQKvG5UBs8aIgIOpiWAU+HhOGWd3nMTk38okccPT3dbVGw2WrcM2i+dHnYaF3I+RW8CQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Cro9fBXYbze5UzjCDsZOrXirBb0DHVoMdnrHGCHFw10=;
 b=Vm0Qm5n+HRk8KYiA06sRmCmXZFfsLHVCZhq7Q82TxhKHKINs9qeGsdG/vzbPLVkRGwncreY0IY7SWl20c3IiQu6C6xWiIgEt+CQlfRC6rHyu11yLO3W0FVgABi6E97eodXYjT+pc+Q5Te4VOaRdO1HUt6iv+UtLKitB+3QP7/aQzHmLnpkLXV5M37bxJWbyzhUItOPBk1Y+VXagAQeRdajJDs94GMBldd48veG4VyAgYlqT7Coqqgw1LuyxMvwl/6q6Ll37uFUD6lsV90ws8ROzqwn1UZvMbYXlrPQC+yIdfzK/gt91zD9KeaSseVeAZLxDbOkX9jgwzskcSGbnfTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Cro9fBXYbze5UzjCDsZOrXirBb0DHVoMdnrHGCHFw10=;
 b=pI3Ir4SgDUvJ7FPMqmIzFuUSIRzuVMyZIfEQj96afuOiMrNPbgfTvmHHirdc6/ebJziqMku9Yzdow2Y2mMl2ljajrxhsxT43pezXsAEENeVCPSVsH95xb0vxu4scLgUdwgOwZMx5781oqcCISEMYFJqsog9YIOOJewt1uzXaB/8=
Received: from BYAPR12MB4791.namprd12.prod.outlook.com (2603:10b6:a03:10a::12)
 by PH7PR12MB7967.namprd12.prod.outlook.com (2603:10b6:510:273::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.30; Wed, 26 Apr
 2023 20:01:40 +0000
Received: from BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::3103:ba85:b667:315d]) by BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::3103:ba85:b667:315d%7]) with mapi id 15.20.6319.034; Wed, 26 Apr 2023
 20:01:40 +0000
X-SNPS-Relay: synopsys.com
From:   Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To:     Roger Quadros <rogerq@kernel.org>
CC:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: dwc3 gadget: controller stop times out on system sleep
Thread-Topic: dwc3 gadget: controller stop times out on system sleep
Thread-Index: AQHZeFqc4s3gM7Yov0WTj+Z9vn7u3q8+Ax8A
Date:   Wed, 26 Apr 2023 20:01:40 +0000
Message-ID: <20230426200140.xa4unnbaw2vog2je@synopsys.com>
References: <24c9f271-ed74-fffa-a49f-6e83da857593@kernel.org>
In-Reply-To: <24c9f271-ed74-fffa-a49f-6e83da857593@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR12MB4791:EE_|PH7PR12MB7967:EE_
x-ms-office365-filtering-correlation-id: 8368bcb1-3d1c-4da9-2537-08db46910cc1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 310ZsrediXfMGMH76tGWtDVkwizmL6NRyODLnDiUa2kiXW/9AwEF5Psw/d4z/OAl3ooKAqYwZkKpMxiz4uxuaEJluNAYhSok4xpDRnbg5CyAARgDAYbERL6RnGVYGgKI5CPMKMWqSDW1CRT/ZkuCX9tmUiV6PEyiUH9SJFgmqTYMQgeXIu2rSLTijV0g+YObByl5ErKrQ28URc6LvUOB35DprYunx4tDzzXhKvuaMl018luxzv8/Ogh8zOi02caGSK/Yt/Ys6UTTjQeE09EJCVNpzoPR7KGweTWqjTO7y+Ih4XgWleQPoHSOhdjew+Weg3rVzo4crGceXl0qkjBsedDoIHsJE2ViLMWv0M1XlpcS1RdpVmOf3emSH3yKF8eZcF+AV7bwV4lki1mgbjOkK7cD95JbQnJzgqWCCyGkxxF+QIzGKUEbuofQy1oSijtuVwvrsaqxiF2BkF7/Iet0fFwK+GcbpT/f56FXaYN2fHet+83xPziNm4jWLJm6tgo+OFrLcF5Nm2vu9JNnD7EcHso+Zw/i0Ib0lqQb55PDMF0MoisYeZSO5id33jlFOIDFMPKQvYt4zDFD4gPrhBPFjBTI2ErK7sONGexV9nCy+6V4Y/hzNNJI7IgENTGT2i6s
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4791.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(136003)(396003)(39860400002)(346002)(376002)(451199021)(66946007)(66556008)(76116006)(4326008)(64756008)(6916009)(66476007)(186003)(316002)(66446008)(478600001)(6486002)(71200400001)(36756003)(86362001)(54906003)(6506007)(1076003)(6512007)(5660300002)(26005)(4744005)(2906002)(2616005)(8936002)(38070700005)(8676002)(38100700002)(41300700001)(122000001)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eXJ6TzRmczY2b3VidzVyZTc1ZUQ5b3h4S2x4dU9vTzA4VEcxaWVTK2lZMWd3?=
 =?utf-8?B?b1pPb2dLeEFxSmt0ZFpBK3d2MGR2UzRSRWJtR1BtclFXMk9sR2xXbUVDWmdD?=
 =?utf-8?B?b1dLLzRBTkRLOGFJRUNMbk40bnFGV09GV0RQczU3ZWVTOXZhQUdKWEQzM0Nj?=
 =?utf-8?B?MWs1ekpnRkR1TjNsOVp2ZE9WWFUrdlhkellocUxrWENqb3hQMkh6WGRaUDNB?=
 =?utf-8?B?dDdsL3pEeHFpQ2JFV3h2bGV6NXdEUVIrQ0JSaDY2K1dNVVlPK1lqTFJQcVdz?=
 =?utf-8?B?eDRrYmpRTHJ1R290cTFYb1FheC94MGdUMDlLMHJPd00zZGtxL1VkRHovWjVZ?=
 =?utf-8?B?UjVWbXg5c0VDYmVWRmdpZnZpajdjTFRxdkNZdUZsMHhUT2hqQUNXZnVSMkZp?=
 =?utf-8?B?cjVvZHRBREwvODZtRC9vUVJFb09iMmNQOC9QRUx0TVRnY3NaMGNFQldZYkVv?=
 =?utf-8?B?SDU0cU0wNWYvcGZlZDg5UEo3dGdRYWlZa1hQZHNUdlpLMEpUcUhEcVdtUnpT?=
 =?utf-8?B?NGNqKzRSUWVHNmx2SUdSKzFGS3U4d2gwaXEwYnYzaTlZM0ZrOE5UbXJpWjc3?=
 =?utf-8?B?VXBveUNpRnZMS0d2N0N0elJhN0QrSFY1eUZKQzRJSklMRDN1bmdLM09KV01w?=
 =?utf-8?B?K2hGU1ZNMTBVLytmaUNNdjdPeFBnQkJaQ3lEa1I1VFRDb3RzWlhzM05sNmZH?=
 =?utf-8?B?SDgvMU4rTHFDaFlWYmk4L3FhZWE1NUpMS0crN2hHdURpbHVDOW5SZDg3WkVF?=
 =?utf-8?B?bFVBSjh5R1lFSHhMdkQxZmZDSWk5Y0NWSnVtQmJIYkk3SnU5a3hvRUduOVY5?=
 =?utf-8?B?OUpWWGVvWmVqQzNVRWpTdm93UEUxMnE3TEMxeGZPRXB6SzdIRXdyNXNTU0x1?=
 =?utf-8?B?QXFOYkZYTkpVMDlYSXVIVEdtY2FmM1BoUzF3NU9WKzd2R3lYdzFWWit1UmVG?=
 =?utf-8?B?d3UrZHF2VzZQOGlsdzYwU1RvMG5SUnQ1Z3VmTHdzQ3IxRHZkNEtIcUJXY2JH?=
 =?utf-8?B?NkN2MzdYRldYTG9iQnYxbmtUL1NNTWJvb1Y1bkN1eWRrNEpjVWI0WjltcHlY?=
 =?utf-8?B?QVFvQWhwNlZ1MmlycGJaT096OW40N29mVFE2dTVVV252T2I3aFFLUlRoTlhK?=
 =?utf-8?B?S1VlNjJ3VmQwL0MvM0lyaDNOUTRrc3JXVHIvUFA0aTRjNHpRaC9Wdy9GU09q?=
 =?utf-8?B?ejRaNURGQ2lLNHV3SlpyeGp4ZzJhOS9sMjRSdGVCemlZWkMvd0l6Z1pJYTY2?=
 =?utf-8?B?UUpuLzhUKzl4bUQwaEFyN3NHcmV4UVZPZUxONGYxblpCbkQvUndaNDJ0aThr?=
 =?utf-8?B?OStyYkd3eTcyY0k5U00xbm1zUEJIR0hHcUZsVDJWa0xBa2dXTWM0Yk1GZERS?=
 =?utf-8?B?TFp0OUxIcGhwOUdCTkQ1dCtXU29Rd3dsYzdIdENvOUV0UjNyY1ROSUdIY3dn?=
 =?utf-8?B?dm52NHJYSytuOURxU2tEdDZSTE5RVDAycGlPT0VmeWJTdEZTSUJYbDBsTGN2?=
 =?utf-8?B?ZThyOVJqTkc3N1pjUlY3NytPVHBvVStvUlJwbVRwYWlJeUdyUEcwVWZPbW1F?=
 =?utf-8?B?N3dNZmx6K0wwRnZWdkQycWlqNzR2SS9qKytCMlE4UE4rVmx6QklERXJXMXZp?=
 =?utf-8?B?a2tjejRQR1UyTkwzc0hETUVUWDV3T0VGU1FOdUM4TjdVSUpJSTZTcmVHaGMy?=
 =?utf-8?B?NmI3NmFoNGtNb2t1TlFPUk9BSmdnMTVxRnR0RXc2MDB5ZUpRaUp5OFBtaEo4?=
 =?utf-8?B?ZmF5Qmd1RUV1UnRQalBOZFlTU1BmU0ZXUVpEazZLT3VVUzVVeGdvT2I1Q0Zw?=
 =?utf-8?B?bmxFMTlNV2xtZEVIeUE3VVpVNkFkeTdnblp5TndZN2dRUjY4eUJGMExXUjVT?=
 =?utf-8?B?N00wZ0VQZ1dHRzZNd1Q5RU5sOTZQRCs0ai9jaUd5d3JzLzZLSnVEb05tSnkv?=
 =?utf-8?B?Wlh5MHFjUnNyNVBFNkxKUmY1RlZZYlNXc0NveGhaT3F4Rm1wcXFGamFLSEJz?=
 =?utf-8?B?blFiblp3OW5ZdS81Zkl5YVZ0VjJ2QngyNkQ4bXRpbFdObVhyZktXdndodGNY?=
 =?utf-8?B?d3JKNWJVcm9DbFZXYVFYY3h5TXRqSFpYczlobUtTdVdsQmxtNXlnNWJxVzdt?=
 =?utf-8?B?SFlEWXhxNDlRM2tNbTgxWWp4S2hPeWR4OGpXdE9VTFZSUW1HK1RFMlZuNnVW?=
 =?utf-8?B?OVE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <001E628DCBF6DA42A37A4D2A052A2A93@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: DfnM3EzLTrfMtPUZqyed/NsruWzn62iJmRlFxpGuzhIBIK5EamRxDD9oSJD/rK7pQsZOWa4rB53zD2DXUp3NxkHfsK0LiPBYOyTZha5BF1JAbuNjQ9ZtRyWNoP4BBurP9+Obzhyc1O5k0xqTWxo81DYau+a2R3t5zvdY9eKBvJnL6Un2j7aMlOkNQ/fXxaDmmz7wQaTVYKGNgcP+bJsmQnknBdoxgxwTrtCP+UX+g7uO3/++8c1OYajqE9foqBe8ZRlc0OhyT54L5pvO66FyPhreVjnCsJAWv2U+/bSzPULqyKUScNcaLHfxFEFUeG/hsZeyjMtHvOSiID/pEavdLL40KYpAQ95RT7IzRQdMGqoied3KVBxV8uUNRDBpc1lppmVdfm1oL/ZJLKsZ/9I5OJ5TKpcYZeNuMwXkgppzGSdH7iTIuRgFJeVTGhf9kFDqPx1oIJKZX1+ZBsxXWuE4ftPFw7SpVJCTMpVpIuzXlrePC39WxFDFzsMUfplMuCKPmOYUa6aPufdVUKDF4tAnR09O2NC0RgRgJ2dHotpcXR2mWlRtP/cjJYxPMsx8A+++HeyCeh8Ng1+l7LmBLKCFDnnrp3+B3AsbkPgkrr/bI0weKQSdibN0ah15fsuUReWF4EA8MwXtvN6S8qouIzlKLV+I5nPGVZsBVDS3beG23Oi0ry7SiCMSA9H40Kcw1Hqwu1I60peRFl5RX5ZCJ+x3UuwlgiePNU7Ff5Mmpm88cRh8wbA5Y5u+ei2oUumkZ2/DTQNjlPYzcDLsPVhkaMKqUJ/LMaAADl5dhhIS70wyvW/HSfUsy0dlG2rB+z63UQ01TiqzR3sopPaY9Ey8imA5v8RsNhYMNOrDgjqxrcWd5gwmaRKe2XvbgL53U/yK6BZe
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4791.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8368bcb1-3d1c-4da9-2537-08db46910cc1
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Apr 2023 20:01:40.0892
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3aLX42ZQR5QEzXjMR0PgAOP6JKHT7kqijv7AdUyc0T8GdThKBnSYZsVlvzKWknSRXRjeY2rwbQwcM1jtoBLGfA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7967
X-Proofpoint-GUID: PR6NWQC-DgmgTvfRKUsQYfqk_1HNDsEk
X-Proofpoint-ORIG-GUID: PR6NWQC-DgmgTvfRKUsQYfqk_1HNDsEk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-26_10,2023-04-26_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 priorityscore=1501 bulkscore=0 adultscore=0 clxscore=1011 spamscore=0
 mlxscore=0 phishscore=0 mlxlogscore=668 malwarescore=0 lowpriorityscore=0
 impostorscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2303200000 definitions=main-2304260176
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksDQoNCk9uIFdlZCwgQXByIDI2LCAyMDIzLCBSb2dlciBRdWFkcm9zIHdyb3RlOg0KPiBIaSBU
aGluaCwNCj4gDQo+IE9uIExpbnV4IGtlcm5lbCB2Ni4zDQo+IFRlc3QgcHJvY2VkdXJlOiANCj4g
DQo+IC0gbW9kcHJvYmUgZ196ZXJvDQo+IC0gQ29ubmVjdCB0byBQQyBob3N0DQo+IC0gc3lzdGVt
Y3RsIHN1c3BlbmQNCj4gDQo+IEEgbGFyZ2UgZGVsYXkgb2YgMyBzZWNvbmRzIGlzIG9ic2VydmVk
LiBUaGUgZGVsYXkgY29tZXMgZnJvbSBkd2MzX2dhZGdldF9zdXNwZW5kKCktPmR3YzNfZ2FkZ2V0
X3J1bl9zdG9wKCkgd2FpdGluZyBmb3IgRFdDM19EU1RTX0RFVkNUUkxITFQgdG8gYmUgc2V0Lg0K
PiBJdCByZXR1cm5zIC1FVElNRURPVVQuDQo+IA0KPiBBcmUgd2UgbWlzc2luZyBzb21ldGhpbmcg
dG8gZG8gYSBjbGVhbiBzdG9wIGR1cmluZyBzdXNwZW5kPw0KPiANCj4gRllJLiBVbmxvYWRpbmcg
Z196ZXJvIGRvZXMgbm90IHNob3cgdGhpcyBkZWxheSBvbiBzdG9wLg0KPiANCj4gY2hlZXJzLA0K
PiAtcm9nZXINCg0KV2hlbiBjbGVhcmluZyBydW5fc3RvcCBiaXQgYW5kIHRoZSBjb250cm9sbGVy
IGRvZXNuJ3QgaGFsdCwgdGhhdCB1c3VhbGx5DQptZWFucyB0aGVyZSBhcmUgYWN0aXZlIHRyYW5z
ZmVycy9lbmRwb2ludHMgdGhhdCBhcmVuJ3QgZW5kZWQgeWV0Lg0KDQpUaGUgZHdjM19nYWRnZXRf
c3VzcGVuZCgpIGRvZXNuJ3QgcHJvcGVybHkgZG8gYWxsIHRoZSBjbGVhbnVwIGJlZm9yZQ0KY2xl
YXJpbmcgdGhlIHJ1bl9zdG9wIGJpdC4gSSB0aGluayB5b3UganVzdCBuZWVkIHRvIGNhbGwNCmR3
YzNfZ2FkZ2V0X3NvZnRfZGlzY29ubmVjdCgpIGluIGR3YzNfZ2FkZ2V0X3N1c3BlbmQoKSB0byBm
aXggdGhpcy4NCg0KVGhhbmtzLA0KVGhpbmg=
