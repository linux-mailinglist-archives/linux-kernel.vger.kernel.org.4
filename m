Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A8F5705BF3
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 02:31:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231538AbjEQAb3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 20:31:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230500AbjEQAbY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 20:31:24 -0400
Received: from mx0b-00230701.pphosted.com (mx0b-00230701.pphosted.com [148.163.158.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C99D940EB;
        Tue, 16 May 2023 17:31:22 -0700 (PDT)
Received: from pps.filterd (m0098572.ppops.net [127.0.0.1])
        by mx0b-00230701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34GKGuN1013809;
        Tue, 16 May 2023 17:30:56 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=pfptdkimsnps;
 bh=aTxSyP+IqxOZ2MPqYr0FfSmgeTaeyRtk0q+u0BkgXxw=;
 b=cjaB/wL5VOrdmgsNfqJp4h64Z9iz/xQYDn82ZZ0Ec4IhAgTtdLcmJDevVxtelqV1LbzJ
 SIGxMWYV99gSNNI9sBqnmb010zJlTkLT1Er9kS6JHZ1vjK8ItLFoGEUiMYcThrAS1P4L
 9Xut9w9dKSctiNx++QnUmkLe0fAladTPkOITuLz3mYrgT1vjGSOgN09EurSy1V+OjUYQ
 3yEAsECIx+Q6ENGwDsYqMITAeK1KhJJvPx5xJ/DU5RB+WBFwVg6fiJAR12Uanx/7cVs3
 mt9NW8QGcStK8ND7zNQQiKBleQS2U28UQU4gHfjJO6+dyUfLDWymvthmR9jB60OOx9ht 4g== 
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.73.133])
        by mx0b-00230701.pphosted.com (PPS) with ESMTPS id 3qj96ehh67-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 16 May 2023 17:30:56 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1684283455; bh=aTxSyP+IqxOZ2MPqYr0FfSmgeTaeyRtk0q+u0BkgXxw=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=OiISkwGY01hwD/Nd6oTgCCsdRqgHsQNpvjBT1rvUg7sy+kjsZWSwtKPDrn+W5I79K
         etMFPylgohA/1D8J9PKHpTyg3k649qzcT3pF8zrfpRx9eVN7IynNc2bbQtYzhMg8Yk
         93kZAXL4RuezIolVV/T2+RMWp7BQTlhdxW8jx4gXyf8/MZ/bUk1CVrrAbY9qxxk3nP
         fqX4ge6eWg7fkI3snk+CqZmOKrt/lCOTjD8pW6mp31TyL2keejMj0FGcKK/NtTgo/1
         QxQwg9rfxuu3u3OsmJlGt2fDtFerkc5oSDrnLmy5o1bPIQaby5xYtFkDRBG6UO2j7z
         E+PEYLU2l1xyw==
Received: from mailhost.synopsys.com (us03-mailhost1.synopsys.com [10.4.17.17])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits)
         client-signature RSA-PSS (2048 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 1F23E404D1;
        Wed, 17 May 2023 00:30:55 +0000 (UTC)
Received: from o365relay-in.synopsys.com (us03-o365relay1.synopsys.com [10.4.161.137])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
        by mailhost.synopsys.com (Postfix) with ESMTPS id AC4C7A0083;
        Wed, 17 May 2023 00:30:54 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=FYuOiFyJ;
        dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2042.outbound.protection.outlook.com [104.47.66.42])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id 5BDED40520;
        Wed, 17 May 2023 00:30:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FQki0XTIJ9Ne/c/5JWZ0t75jnYLtnFG2DalZF3n4TTxBEO5NfGdvJcmSekvVJoLhwHgh3OoEev4hsVsdQCaYG88cEST824Hiyq8pCXmukQPIS5sryBBb1NIn4/ePqd9TuwWkwAhJdhrDBRNlyExmOJxoN6K+VeJJxLFgQBu/9Go5YNBF6zHIjXVXg57RjSVGSp5/zsUWyvGG7waMylFm8yhOCbnQyzH8PUrnLuOqIqHIUSYrRVDdhTsns8bN0S34/YleWFC71uCluMnAGJyQb+dtIQdLGf0EAii6MhgxgSTczeWaVnB5dtRCrGJ4i6/aJOk2wRkyimwg9b14BhA7XQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aTxSyP+IqxOZ2MPqYr0FfSmgeTaeyRtk0q+u0BkgXxw=;
 b=oYNWFwm1rfJTIGQ8V5Uj77KHmedNo3tfKP7riCCGzaFhLeidISpcdYf6rXnHmJIBdKb5Ag0kX+0t+L+hEfAg3lpL/3sBvwbDpVjNqEcacCc7BDIQAU+JszZ9iVlK64jVyu6AZdoAhMlrrAUlJhOHJGEu6E+KMdDW57Hbh1ZThq4JHkRgVT9u9z5ZELI8Dn9F5Ll0geSQ9hbcvzKRvnQClel3AzbzInF+fGwxK/Dm4O501qeO5MifdQhFAgOB9Y5kqKSIIjjuCi+fRWoi7a/m3stK2HYQRrGvKu6zRudCkhzokkzJIKmRtp4eribdiBAW31MEhitDOgaQhfERbh5HNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aTxSyP+IqxOZ2MPqYr0FfSmgeTaeyRtk0q+u0BkgXxw=;
 b=FYuOiFyJB/XkvtnfjgFvBrDaX5O4KDLTDb57Oad8X/VDfM/tKPjc8VoA5k0wpWqfFSzKAk+pWO336u+5znpHpsKp+fXSdIjDgM8DV/MIrM1QgX3KLWfge/nM7iJlt2sGabNOKJWLnXyxCHXMxqCG+Maf46JEkb4SuwtAUNUwJ0A=
Received: from BYAPR12MB4791.namprd12.prod.outlook.com (2603:10b6:a03:10a::12)
 by CY8PR12MB7634.namprd12.prod.outlook.com (2603:10b6:930:9d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.33; Wed, 17 May
 2023 00:30:52 +0000
Received: from BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::3400:81ff:f191:b312]) by BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::3400:81ff:f191:b312%5]) with mapi id 15.20.6387.033; Wed, 17 May 2023
 00:30:45 +0000
X-SNPS-Relay: synopsys.com
From:   Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To:     Krishna Kurapati <quic_kriskura@quicinc.com>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "quic_ppratap@quicinc.com" <quic_ppratap@quicinc.com>,
        "quic_wcheng@quicinc.com" <quic_wcheng@quicinc.com>,
        "quic_jackp@quicinc.com" <quic_jackp@quicinc.com>,
        "quic_ugoswami@quicinc.com" <quic_ugoswami@quicinc.com>
Subject: Re: [PATCH v2] usb: dwc3: core: set force_gen1 bit in USB31 devices
 if max speed is SS
Thread-Topic: [PATCH v2] usb: dwc3: core: set force_gen1 bit in USB31 devices
 if max speed is SS
Thread-Index: AQHZhnOYGWoDiciaPkad/64K3wvwX69dmz2AgAAFdYA=
Date:   Wed, 17 May 2023 00:30:44 +0000
Message-ID: <20230517003037.i7hsg6k5fn4eyvgf@synopsys.com>
References: <20230514145118.20973-1-quic_kriskura@quicinc.com>
 <20230517001105.v74dyo6asqtcrpii@synopsys.com>
In-Reply-To: <20230517001105.v74dyo6asqtcrpii@synopsys.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR12MB4791:EE_|CY8PR12MB7634:EE_
x-ms-office365-filtering-correlation-id: f5cb6c3d-7416-45fc-ba00-08db566df3e8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: YQ/CF88e1PN3BkSYzSjn44B4zZdbHCxE3Q/twW29s0fxCDUy98eUZpC1n+KsvE8P9q2dh51+1rJRJ+ukR9YPdIN4CIqTWP4trhUtdRqtZGCZyYwC2+4fndOCKp3hqCF57tzyjJpbhyR1rDeyOv7rmNbsNXhtu+7Sgi5+jW0TVUolPLnzozOPUGeIFEI3uabdYS1kpH2LdLtIcebVQaf7Z4ft4d1sZyCbLSzr75QDyEHbt+LIcBI4NnHGqfWNl0SP3iUAyQp3ZJUxmj+zMFYnnQJndMcL3cTZYXvumAwJo8eYqvOE7RhcB6oZIMc6Z9/eVy6Prq95eUY//c06e6fXEsJJPGu3z/NGKAv5bMG8RPqAwGl+A3Nf1GwDpdh/2/CWy/x55r9uQk3NHzufd5tEs141mo2Gp38ramlc1CD71PaaubiecHFFqlVkJ5QaB1gLVr+49uIMMQNbKfN0JXMly9Fgj6ViJKCcz+7pmVQYPidXH1fLt4HqPy9JnDLVpfTdrY/k8OIf8eEGdp2rcj+ETeFCOzf8cWSxtOUwRmS0wKg5pH0sId/40/7x8lbrvVochSOkHvi5WfzASTu50rbgOXmdvR8oDbWbFp6OrT1MjE1Y0AQZRK7AFUxNh2LHHgZaaUeFbOSTf3XxKdNJWbY6iw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4791.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(39860400002)(366004)(376002)(346002)(136003)(451199021)(36756003)(6916009)(2906002)(4326008)(5660300002)(64756008)(8936002)(86362001)(8676002)(41300700001)(66476007)(316002)(66556008)(66946007)(66446008)(76116006)(478600001)(54906003)(71200400001)(6486002)(186003)(26005)(6506007)(1076003)(2616005)(83380400001)(6512007)(966005)(38070700005)(122000001)(38100700002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bHhhUTFmaUpDZCt4VmYxVmpEQUhHTFY4TGNMcUMvNmFFV2o2WEg4MktWR2U2?=
 =?utf-8?B?THJMNDd3S25mZVVBU3puMTV6S2NZcjJ2aHhrT3JLRkgwRWh4Wk4rMUxQcm9D?=
 =?utf-8?B?aXVoVlZYUkQ2WElsODdLMUc2TkoyVm9BUEh1UkEreHkxY1doM1U2Q1hSTVJs?=
 =?utf-8?B?RFFyTm1mWXYzM1dZQ29JQWpGOS9KT1haSE1EK2tsZHR0Z09wbmdGMm1UdkRT?=
 =?utf-8?B?MXJwUDI0VHdQVTlZbUNIOENjcmdmU2k1ZHBWWUVhL3J3NGlOTmU4L1Z2QlRl?=
 =?utf-8?B?UGV0aEUrWDF6WXpBeDM3d2hjdXJnZ0l0L2ZITzdETVBGK25LUnRiT2VCTHZF?=
 =?utf-8?B?L0JpUWdMVC8ycHVuTlI4aDBTZUNPL2gwdGp3QVYraElJTTRzL1FBdTBTN1lp?=
 =?utf-8?B?ZjEyRDI0TWc5WnRHSXVFZWgwWlVPTlRoMDY5VlJWa1ZnTnV0eDhpV2t4WEhq?=
 =?utf-8?B?V1hjVlZRZ2dqSHVZRkpsN1puQmNTT3A1NUhyK3VjcTB1ckRjL1lRRytRS2cz?=
 =?utf-8?B?cVFvMWVJL0JlNklVZ2NEamNTSjh4dXcraStPTEhkNFRTZ0syQ1ZWd0s1TnlM?=
 =?utf-8?B?Z3cyRXN1Si9RbHlXaWF3Wmp2TzZsVUYrQ2ZzNlpMeW5sQTIrS2JPblZGVEZy?=
 =?utf-8?B?R1JaNDBiaGxCQWlreXRrT0xjK3BuL1pGSU9XSXlkZi9BNmpoTnpNWnFUWFl5?=
 =?utf-8?B?QzN3M09DYXlOQTdGWUM4cjM2azQxRVc2UEd3OUZNLytTU005VW9zOVAvVkg2?=
 =?utf-8?B?SU5hQXdTRW1Gd1RuRVp2ZlIrK2VVYmdmSTI4blREQUEzWDJka0ZMV0RIVm1w?=
 =?utf-8?B?KzJNYTZCSkJiRy9aNUk4ZWtaM0RsdlRqdkVFejJMcU5oSEN2WFllam51UVVO?=
 =?utf-8?B?UTROajltOElDeVZrV0tPOTJHVkNQYk5KMDkrbGtLWlRNT241K3h5REVIenZv?=
 =?utf-8?B?WEVjemthaGVCRkpZUTFwdGZlOVA1R1RpWEFERHRBejVtTU9ucFdGb0p1SmMv?=
 =?utf-8?B?ejNuVmJ2RXI4Ni9ra1ovUmRDZjJXYkQrekcwK2UwREl6Z1hDZkFxeFFaRjBI?=
 =?utf-8?B?dGRpZjZycWxjUVlUUmFzejBrWEFIUW11T3FxRkYrc2lWLzA2TVZCY3lNdHFY?=
 =?utf-8?B?eERaZ3FyUDZlWURFc1BYUm9WZlBjaksxdmJXN2JHZThCQ1V3eFJ2ZE5mT3lK?=
 =?utf-8?B?RkdOQTYzNFpjQlFiZVM5WkJHNlJZRnhFTHB5eENQZjhOelE0d1ZDTmVldVE5?=
 =?utf-8?B?MWcvMG4xN0pmNkZWWmFDanBES1pTeVNtTWxqUkVYVURLTlFGR2VqOWord1dK?=
 =?utf-8?B?UG9RTnRBWVV1U0FsbnFBcjVxbWpGTVZUaHREQnJmV245bGMzL2xMZjdEUlM3?=
 =?utf-8?B?RzE4RXZ3dzN3MG9HVXBJMXhlWi95S2FNL2FNRC9zOEZ1MjZEcm84blE0SlBr?=
 =?utf-8?B?VWxmOUZLcVpPa1ZaaTNsMVo3dEZBSWZkWDJuRGFKUlltb2Z1anA3WXh0YUsw?=
 =?utf-8?B?bi84UEUwSHJyY05ZcVFRanBKbkJBTk1mNVllNHhkNkszampJSFZWZTdBVVkz?=
 =?utf-8?B?cUpidk04R2JQQmdMaXUrUnVqQ1B4MG9jRDJmeWhXcTFBYTZhcWdGZHQ4OVp2?=
 =?utf-8?B?SnZFUnEwbGlyazNmUFJIWTRVVGZIMm9oMFhQVEFrMlI1QTJTNGRrYStBVHll?=
 =?utf-8?B?Q1l5WDhjV1JiTS9Ya3FOcmlQUXZpN3d0UGg5T2w4VmdNR3RKdVh6YnB6RjFl?=
 =?utf-8?B?Z1BjUjdPSC9uMUZPU2o1T2tNUUVHNGZpbzhiMVJBNmF3Z2c0OU00TWllWWZR?=
 =?utf-8?B?VUNuU0l1ZFQyQy83N2IxY1RuM2hSMGI2ZUVQbm0zTzBZbjBhc28wSHhCczJm?=
 =?utf-8?B?YUlhSUdMaVJ0ZVB6N1dZZ2NJQTcrdktsdkVxeEs3akhrZ1hEaEdkWUJYamo5?=
 =?utf-8?B?dmRYM3lXMFJuUFNacTF5cEVPa2tJVTZBbTRRR1lsbXpXK2tUQjVSeEJ3SWZQ?=
 =?utf-8?B?R2VXSCtxalRjNkxVRU1NS3V4MUtjMmhuM0lISnhqOHhQZVpDQ3Q1cjRhTFoy?=
 =?utf-8?B?bkhHMUZ2TjBsdVByQW1xTENVYnJ5V0xnMUQweE94U0lHNG5TZWptcnQ2NytV?=
 =?utf-8?Q?1ObOyJwE62ez9KAk3fNwk+mlw?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <DBB15AE8FE513D4AB17832C9ECA4F61A@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: +pVkG8kA7C1E+4pJaqFIwknrKaqELlh7HkdxopsNAxHpLi18eWAhDBCVmGl0ElKlUaaKzrD2YppFHKZ0lLNbPq39VGHFPCbZUJ0H2+QiNSGOB0dDVmDHqbTXdlabO+3WcI/bdHzGslD3zXWOq3qU+cV3Q2s0IeQTrXp1bofBznziNedJZnZNVUyBQa48bmUO4UaC5hkY3Nmy/fwJRUdIEcmH5WiRNATpFOGKUQIvOI1g++Qizf6w5O/dUO30EGws7PGdjO1sB1q8vzj1A+8kC1yng2SWy2IupycFAAxUDwNK13G7CmarhOMw03DQuPSBkEGdSPF0qqpLYV/DazevOMsEOlpHx6T3N6N7vJg2ucovNbjUema5X11lDT3IDEi1edDEHDrOFS07trC6/JKxIjisX30u4RXzQm1Y+3TRt762kHB2AVee2nMCJjxRio2Vd7dOOumYKpTgmfP/qjMrsO/LZxrWEKtny5B5vcE1ocQX/ZNzMiR48ZRgYigmNfJxx0t+YuQ1iyo/MzETgzi1jweSleJV2qhqZmf3+amJyijojU9WDOmebVry/kRUY6kDdbvcPzUDrxOLEmSnAOebUZvj6/D5sFEnG1nbUh8BXaedApYY0qsDeSEflBy1xQSKO2r1VsdVVXfytvacAnYfIFxbJkdQOszd4jJ97kQdKvgtEo509ayG6lO4GreH+euJhtPwXeX//A8+4YbaNTKnTHdK0kfOGf+SOSmLDTURdG8r4kWWm7EyM66pDOfocuucJoYJ2RypT3vYexayzP3wzCfyQgzgmNFK8Cxe7/DfIw5E1yog414zrLSh+QICMPtdqiE8XjKcXRal+GS7eedFbIbdMH2KaGu/jhDpm2j/0XgcIJMzRP1C2Xy5CXJbj7yXQwm2uXV4QQNOEaFcSqOYfw==
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4791.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f5cb6c3d-7416-45fc-ba00-08db566df3e8
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 May 2023 00:30:44.6399
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TOszPjH7Myx4FVnBXz1GCwtoCW/8xyfvky7WuZsmniKvf4CtvT+FzpeLqk0F4ko9Ft8SDnKhoPa0zBAQUs2oaQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7634
X-Proofpoint-GUID: 0BdZFltWfN7oHSdqXi6gNjwcrd-_NVsJ
X-Proofpoint-ORIG-GUID: 0BdZFltWfN7oHSdqXi6gNjwcrd-_NVsJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-16_14,2023-05-16_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 priorityscore=1501 impostorscore=0 malwarescore=0 adultscore=0
 clxscore=1015 lowpriorityscore=0 phishscore=0 mlxlogscore=999 mlxscore=0
 spamscore=0 suspectscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2304280000 definitions=main-2305170002
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCBNYXkgMTcsIDIwMjMsIFRoaW5oIE5ndXllbiB3cm90ZToNCj4gT24gU3VuLCBNYXkg
MTQsIDIwMjMsIEtyaXNobmEgS3VyYXBhdGkgd3JvdGU6DQo+ID4gQ3VycmVudGx5IGZvciBkd2Mz
X3VzYjMxIGNvbnRyb2xsZXIsIGlmIG1heGltdW1fc3BlZWQgaXMgbGltaXRlZCB0bw0KPiA+IHN1
cGVyLXNwZWVkIGluIERULCB0aGVuIGRldmljZSBtb2RlIGlzIGxpbWl0ZWQgdG8gU1MsIGJ1dCBo
b3N0IG1vZGUNCj4gPiBzdGlsbCB3b3JrcyBpbiBTU1AuDQo+ID4gDQo+ID4gVGhlIGRvY3VtZW50
YXRpb24gZm9yIG1heC1zcGVlZCBwcm9wZXJ0eSBpcyBhcyBmb2xsb3dzOg0KPiA+IA0KPiA+ICJU
ZWxscyBVU0IgY29udHJvbGxlcnMgd2Ugd2FudCB0byB3b3JrIHVwIHRvIGEgY2VydGFpbiBzcGVl
ZC4NCj4gPiBJbmNhc2UgIHRoaXMgaXNuJ3QgcGFzc2VkIHZpYSBEVCwgVVNCIGNvbnRyb2xsZXJz
IHNob3VsZCBkZWZhdWx0IHRvDQo+ID4gdGhlaXIgbWF4aW11bSBIVyBjYXBhYmlsaXR5LiINCj4g
PiANCj4gPiBJdCBkb2Vzbid0IHNwZWNpZnkgdGhhdCB0aGUgcHJvcGVydHkgaXMgb25seSBmb3Ig
ZGV2aWNlIG1vZGUuDQo+ID4gVGhlcmUgYXJlIGNhc2VzIHdoZXJlIHdlIG5lZWQgdG8gbGltaXQg
dGhlIGhvc3QncyBtYXhpbXVtIHNwZWVkIHRvDQo+ID4gU3VwZXJTcGVlZCBvbmx5LiBVc2UgdGhp
cyBwcm9wZXJ0eSBmb3IgaG9zdCBtb2RlIHRvIGNvbnRyYWluIGhvc3Qncw0KPiA+IHNwZWVkIHRv
IFN1cGVyU3BlZWQuDQo+ID4gDQo+ID4gU2lnbmVkLW9mZi1ieTogS3Jpc2huYSBLdXJhcGF0aSA8
cXVpY19rcmlza3VyYUBxdWljaW5jLmNvbT4NCj4gPiAtLS0NCj4gPiBMaW5rIHRvIHYxOiBodHRw
czovL3VybGRlZmVuc2UuY29tL3YzL19faHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvYWxsLzIwMjMw
NTEyMTcwMTA3LjE4ODIxLTEtcXVpY19rcmlza3VyYUBxdWljaW5jLmNvbS9fXzshIUE0RjJSOUdf
cGchZENnXzNXSzJvTlhOYjZkMGFfVnV5amtlZVpKVFUxYVk0ZGlrNmczNVhCN210RzdFSmVSMXVQ
TWZ4RmphNDlPZlhwN1loc2cxeXFqbnlsQ1lZRWc3WUNBaHFmQVowUSQgDQo+ID4gDQo+ID4gRGlz
Y3Vzc2lvbiByZWdhcmRpbmcgdGhlIHNhbWUgYXQ6DQo+ID4gaHR0cHM6Ly91cmxkZWZlbnNlLmNv
bS92My9fX2h0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2FsbC9lNDY1YzY5Yy0zYTlkLWNiZGItZDQ0
ZS05NmI5OWNmYTFhOTJAcXVpY2luYy5jb20vX187ISFBNEYyUjlHX3BnIWRDZ18zV0syb05YTmI2
ZDBhX1Z1eWprZWVaSlRVMWFZNGRpazZnMzVYQjdtdEc3RUplUjF1UE1meEZqYTQ5T2ZYcDdZaHNn
MXlxam55bENZWUVnN1lDRFJMVXJKV2ckIA0KPiA+IA0KPiA+ICBkcml2ZXJzL3VzYi9kd2MzL2Nv
cmUuYyB8IDggKysrKysrKysNCj4gPiAgZHJpdmVycy91c2IvZHdjMy9jb3JlLmggfCA1ICsrKysr
DQo+ID4gIDIgZmlsZXMgY2hhbmdlZCwgMTMgaW5zZXJ0aW9ucygrKQ0KPiA+IA0KPiA+IGRpZmYg
LS1naXQgYS9kcml2ZXJzL3VzYi9kd2MzL2NvcmUuYyBiL2RyaXZlcnMvdXNiL2R3YzMvY29yZS5j
DQo+ID4gaW5kZXggMjc4Y2QxYzMzODQxLi4zM2JjNzI1OTVlNzQgMTAwNjQ0DQo+ID4gLS0tIGEv
ZHJpdmVycy91c2IvZHdjMy9jb3JlLmMNCj4gPiArKysgYi9kcml2ZXJzL3VzYi9kd2MzL2NvcmUu
Yw0KPiA+IEBAIC0xMjYyLDYgKzEyNjIsMTQgQEAgc3RhdGljIGludCBkd2MzX2NvcmVfaW5pdChz
dHJ1Y3QgZHdjMyAqZHdjKQ0KPiA+ICAJCX0NCj4gPiAgCX0NCj4gPiAgDQo+ID4gKwlpZiAoKGh3
X21vZGUgIT0gRFdDM19HSFdQQVJBTVMwX01PREVfR0FER0VUKSAmJg0KPiA+ICsJICAgIChEV0Mz
X0lQX0lTKERXQzMxKSkgJiYNCj4gPiArCSAgICAoZHdjLT5tYXhpbXVtX3NwZWVkID09IFVTQl9T
UEVFRF9TVVBFUikpIHsNCj4gPiArCQlyZWcgPSBkd2MzX3JlYWRsKGR3Yy0+cmVncywgRFdDM19M
TFVDVEwpOw0KPiA+ICsJCXJlZyB8PSBEV0MzX0xMVUNUTF9GT1JDRV9HRU4xOw0KPiA+ICsJCWR3
YzNfd3JpdGVsKGR3Yy0+cmVncywgRFdDM19MTFVDVEwsIHJlZyk7DQo+ID4gKwl9DQo+ID4gKw0K
PiANCj4gUGVyaGFwcyB0aGlzIHNob3VsZCBiZSBkb25lIGZvciBldmVyeSB1c2IzIHBvcnQgcmF0
aGVyIHRoYW4ganVzdCB0aGUNCj4gcG9ydF8wLiBUaGlzIHBhdGNoIGNhbiBnbyBhZnRlciB5b3Vy
IG11bHRpLXBvcnQgc2VyaWVzIGlzIGFkZGVkIHRvDQo+IEdyZWcncyBicmFuY2ggd2hlcmUgeW91
IGNhbiBjaGVjayBmb3IgbnVtYmVyIG9mIHVzYjMgcG9ydHMuDQo+IA0KDQpDYW4geW91IGFsc28g
YWRkIGR3Y191c2IzMiBzZXR0aW5ncz8gSXQgc2hvdWxkIGxvb2sgc29tZXRoaW5nIGxpa2UgdGhp
czoNCg0KDQpkaWZmIC0tZ2l0IGEvZHJpdmVycy91c2IvZHdjMy9jb3JlLmMgYi9kcml2ZXJzL3Vz
Yi9kd2MzL2NvcmUuYw0KaW5kZXggMGJlYWFiOTMyZTdkLi40YmQyNTY0YWExNjMgMTAwNjQ0DQot
LS0gYS9kcml2ZXJzL3VzYi9kd2MzL2NvcmUuYw0KKysrIGIvZHJpdmVycy91c2IvZHdjMy9jb3Jl
LmMNCkBAIC0xMjYyLDYgKzEyNjIsNDAgQEAgc3RhdGljIGludCBkd2MzX2NvcmVfaW5pdChzdHJ1
Y3QgZHdjMyAqZHdjKQ0KIAkJfQ0KIAl9DQogDQorCWlmIChod19tb2RlICE9IERXQzNfR0hXUEFS
QU1TMF9NT0RFX0dBREdFVCkgew0KKwkJaW50IGk7DQorDQorCQlpZiAoRFdDM19JUF9JUyhEV0Mz
MSkgJiYNCisJCSAgICBkd2MtPm1heGltdW1fc3BlZWQgPT0gVVNCX1NQRUVEX1NVUEVSKSB7DQor
CQkJZm9yIChpID0gMDsgaSA8IGR3Yy0+bnVtX3VzYjNfcG9ydHM7IGkrKykgew0KKwkJCQlyZWcg
PSBkd2MzX3JlYWRsKGR3Yy0+cmVncywgRFdDM19MTFVDVEwoaSkpOw0KKwkJCQlyZWcgfD0gRFdD
M19MTFVDVExfRk9SQ0VfR0VOMTsNCisJCQkJZHdjM193cml0ZWwoZHdjLT5yZWdzLCBEV0MzX0xM
VUNUTChpKSwgcmVnKTsNCisJCQl9DQorCQl9DQorDQorCQlpZiAoRFdDM19JUF9JUyhEV0MzMikg
JiYNCisJCSAgICBkd2MtPm1heF9zc3BfcmF0ZSAhPSBVU0JfU1NQX0dFTl8yeDIpIHsNCisJCQlp
bnQgbHNyX3NwZWVkID0gLUVJTlZBTDsNCisNCisJCQlpZiAoZHdjLT5tYXhpbXVtX3NwZWVkID09
IFVTQl9TUEVFRF9TVVBFUikNCisJCQkJbHNyX3NwZWVkID0gRFdDM19MQ1NSX0dFTl8xeDE7DQor
CQkJZWxzZSBpZiAoZHdjLT5tYXhfc3NwX3JhdGUgPT0gVVNCX1NTUF9HRU5fMngxKQ0KKwkJCQls
c3Jfc3BlZWQgPSBEV0MzX0xDU1JfR0VOXzJ4MTsNCisJCQllbHNlIGlmIChkd2MtPm1heF9zc3Bf
cmF0ZSA9PSBVU0JfU1NQX0dFTl8xeDIpDQorCQkJCWxzcl9zcGVlZCA9IERXQzNfTENTUl9HRU5f
MXgyOw0KKw0KKwkJCWlmIChsc3Jfc3BlZWQgIT0gLUVJTlZBTCkgew0KKwkJCQlmb3IgKGkgPSAw
OyBpIDwgZHdjLT5udW1fdXNiM19wb3J0czsgaSsrKSB7DQorCQkJCQlyZWcgPSBkd2MzX3JlYWRs
KGR3Yy0+cmVncywgRFdDM19MQ1NSX1VTQjMyQ1RMKGkpKTsNCisJCQkJCXJlZyAmPSB+RFdDM19M
Q1NSX1VTQjMyQ1RMX1NQRUVEX01BU0s7DQorCQkJCQlyZWcgfD0gbHNyX3NwZWVkOw0KKwkJCQkJ
ZHdjM193cml0ZWwoZHdjLT5yZWdzLCBEV0MzX0xDU1JfVVNCMzJDVEwoaSksIHJlZyk7DQorCQkJ
CX0NCisJCQl9DQorCQl9DQorCX0NCisNCiAJcmV0dXJuIDA7DQogDQogZXJyX3Bvd2VyX29mZl9w
aHk6DQpkaWZmIC0tZ2l0IGEvZHJpdmVycy91c2IvZHdjMy9jb3JlLmggYi9kcml2ZXJzL3VzYi9k
d2MzL2NvcmUuaA0KaW5kZXggZDU2NDU3YzAyOTk2Li40MTVlMDIxNWZlMDAgMTAwNjQ0DQotLS0g
YS9kcml2ZXJzL3VzYi9kd2MzL2NvcmUuaA0KKysrIGIvZHJpdmVycy91c2IvZHdjMy9jb3JlLmgN
CkBAIC0xNzAsNiArMTcwLDkgQEANCiAjZGVmaW5lIERXQzNfT0VWVEVOCQkweGNjMEMNCiAjZGVm
aW5lIERXQzNfT1NUUwkJMHhjYzEwDQogDQorI2RlZmluZSBEV0MzX0xMVUNUTChuKQkJKDB4ZDAy
NCArICgobikgKiAweDgwKSkNCisjZGVmaW5lIERXQzNfTENTUl9VU0IzMkNUTChuKQkoMHhkMDdj
ICsgKChuKSAqIDB4ODApKQ0KKw0KIC8qIEJpdCBmaWVsZHMgKi8NCiANCiAvKiBHbG9iYWwgU29D
IEJ1cyBDb25maWd1cmF0aW9uIElOQ1J4IFJlZ2lzdGVyIDAgKi8NCkBAIC02NTMsNiArNjU2LDE2
IEBADQogI2RlZmluZSBEV0MzX09TVFNfVkJVU1ZMRAkJQklUKDEpDQogI2RlZmluZSBEV0MzX09T
VFNfQ09OSURTVFMJCUJJVCgwKQ0KIA0KKy8qIExMVUNUTCBSZWdpc3RlciAqLw0KKyNkZWZpbmUg
RFdDM19MTFVDVExfRk9SQ0VfR0VOMQkJQklUKDEwKQ0KKw0KKy8qIExDU1JfVVNCMzJDVEwgUmVn
aXN0ZXIgKi8NCisjZGVmaW5lIERXQzNfTENTUl9VU0IzMkNUTF9TUEVFRF9NQVNLCTB4Mw0KKyNk
ZWZpbmUgRFdDM19MQ1NSX0dFTl8xeDEJCTANCisjZGVmaW5lIERXQzNfTENTUl9HRU5fMXgyCQkx
DQorI2RlZmluZSBEV0MzX0xDU1JfR0VOXzJ4MQkJMg0KKyNkZWZpbmUgRFdDM19MQ1NSX0dFTl8y
eDIJCTMNCisNCiAvKiBTdHJ1Y3R1cmVzICovDQogDQogc3RydWN0IGR3YzNfdHJiOw0KDQogLS0N
Cg0KIFRoYW5rcywNCiBUaGluaA==
