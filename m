Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 457C268CBE5
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 02:24:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230257AbjBGBYj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 20:24:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230244AbjBGBYe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 20:24:34 -0500
Received: from mx0b-00230701.pphosted.com (mx0b-00230701.pphosted.com [148.163.158.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1017A34C1E;
        Mon,  6 Feb 2023 17:24:32 -0800 (PST)
Received: from pps.filterd (m0297265.ppops.net [127.0.0.1])
        by mx0a-00230701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 316NAgiP029440;
        Mon, 6 Feb 2023 17:24:26 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=pfptdkimsnps;
 bh=jhHkiVenxlACPVBhUGuXbVkRU4Uc2Ymhm3D9fs0SaCA=;
 b=oY54/2KfGV/cpu9oDhbz9nycOfkELFW5VzTJjomZ4PE0ZOmwLtXO/MOTnmZkpYJXnI7G
 /SPWHsq/rNNVQvgQR+ByfJYisxGhrRBYdqgiJEHqM/LkPIv94FbG1rYos6O9d8m/tYa2
 vwJ1S6G2a1u31rWiqNhoWURk+lnkHlvU+JJtA4RoA6Brgj5WXS1gdeDxEpf2jPwWVkvq
 7AoYesNxke97vMqTfjbg2vY3iUUDdOiK+Jlkg+LLcAQFfffLx4x9ETELjtodq8LhdUrZ
 fv0/ZOKKVj8B77DOtFhOBD+7DA65GrMajpc25bvFDPA0Bl1q3yXlY/3P4+sahQCNWvW5 YQ== 
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.87.133])
        by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 3nhq61b7vd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Feb 2023 17:24:26 -0800
Received: from mailhost.synopsys.com (badc-mailhost4.synopsys.com [10.192.0.82])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 244E7C098F;
        Tue,  7 Feb 2023 01:24:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1675733065; bh=jhHkiVenxlACPVBhUGuXbVkRU4Uc2Ymhm3D9fs0SaCA=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=NYe3gBCKOpp4ENDr7UFAX+mHyvBGeSPYH0oYgny/SsDZKpYTv9Fk+j9wdp8IoF9w+
         F2kkZ5sXZW4k5U74NGH2VxfjL+0vTF5eB8AudK0aL2CyIsypOzIQ+MDJ+F5WmXbpTY
         75x3mMOgUQ2QHgNCRbkmHGvwzELqQLnvfT5GvQTH+YRi720+BbtSkZ6UU+adKlt3yJ
         VQKhX7IBmI0O8bf1QLV4+sA2jBkmE7xtmateQoDo5ezTWB08dDIWREbuVqpbQag/s8
         OC2l4j06OHIBR+7cT87v6O1yqYParfHJxLDYGuwLP6d6xJstuoly7Y0vxagBf+Dd5k
         b9RjaciLMmAtg==
Received: from o365relay-in.synopsys.com (us03-o365relay3.synopsys.com [10.4.161.139])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
        by mailhost.synopsys.com (Postfix) with ESMTPS id D8854A005F;
        Tue,  7 Feb 2023 01:24:24 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2108.outbound.protection.outlook.com [104.47.55.108])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id 59E90800C6;
        Tue,  7 Feb 2023 01:24:24 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=thinhn@synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.b="AmJ267JT";
        dkim-atps=neutral
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U5QSpcCfpmdsD6JIjStDcPixqL5GSIbwkFQvAlIBhv+AfwUREGBSlqJK6Et5eNklA6JnhFr1f437XNIQXCDwA6QvWUDdwkJmFa1nlUN/q3/VrEakk3nbodCWvhwD2SelZQuaySf1KXDRvqR80nTSP+LD2ZDHX1Y+VThJHMNXBirLjKsOorBPnQxKm3gf4NN4Ly3ujTLag/wziT4hQi+SC0a2b/ua4bsJusgRU/GKjO/CeieZPx9Gh929MXLLTsNKf2YsC3WYZp63cwVd4qlJit+Y1K8FBMEi5yMSNrPwdaMBIRYWx96yFZeF9tqIQI75xnUzySPtzzn66ADNplAmmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jhHkiVenxlACPVBhUGuXbVkRU4Uc2Ymhm3D9fs0SaCA=;
 b=WImFN33v1rgjYDWv8VNdsG5a0lcJr7tY18sdblDZJJGwFw9jyYtxFIUl70SDbe2xm3itX36nlA0zveBaS5mpxTgzqu39qNc8vrmAsZN4CeBE/Wen0cQs9qMkrIifvkcGfldaTpjDNIHiXtEdibbD3D9cNH6OMLQ0gaA57uYdAxtj7kzYh7+X0oD5iDLgw6NcLYKsDCIRClRI9vVN1X/f+1GewI+7E7ZCtzORvYShxhS823gQ3xe5KBOcOvlt6dinfnhDjCp4StHTd8rxf2NBEQsZuPTtDNAStMm4bYbGvRDfXAJikGD9olzSQKgyZ6teXXpsZAS4BnEXJpP+xTR3zA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jhHkiVenxlACPVBhUGuXbVkRU4Uc2Ymhm3D9fs0SaCA=;
 b=AmJ267JTjyPGu7SbTsqXXJL2qx0RJWmSOQ4IiqozATiaqvpgwy0sgOrWKxa2DGV8XGrDetzlrcAmYjjd9caiC6ssjmSVtv52D805KakGHV95f9xPFYqhEu61e3OX+6QPifAFckB6O7MzRUNwT/rof5dLTN43UoXhD/Nk13TIUM0=
Received: from BYAPR12MB4791.namprd12.prod.outlook.com (2603:10b6:a03:10a::12)
 by BY5PR12MB4052.namprd12.prod.outlook.com (2603:10b6:a03:209::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.35; Tue, 7 Feb
 2023 01:24:22 +0000
Received: from BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::6f3c:bd8e:8461:c28c]) by BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::6f3c:bd8e:8461:c28c%7]) with mapi id 15.20.6064.029; Tue, 7 Feb 2023
 01:24:22 +0000
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
Subject: Re: [PATCH v3 0/5] Add function suspend/resume and remote wakeup
 support
Thread-Topic: [PATCH v3 0/5] Add function suspend/resume and remote wakeup
 support
Thread-Index: AQHZOl8itCO1oArtr0Gr7PlIyOAuFq7CsQYA
Date:   Tue, 7 Feb 2023 01:24:21 +0000
Message-ID: <20230207012412.m2imw4bodu7ehvn4@synopsys.com>
References: <1675710806-9735-1-git-send-email-quic_eserrao@quicinc.com>
In-Reply-To: <1675710806-9735-1-git-send-email-quic_eserrao@quicinc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR12MB4791:EE_|BY5PR12MB4052:EE_
x-ms-office365-filtering-correlation-id: 220f9457-4bc8-495d-fa47-08db08aa0a9b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ihV8VZRbtE1VgdHoHNTaxCBcSdnS3UxxWS9ymhDZEbev99JRXPWzH+vlmvUM4Ox7DWgPKdcLKGr6BPjiSGHCepg42+XMsfi2XaXo4YllXszDTRS98xbtbIuYnIFTWxFBgTUoPyqxGawB8wnDxx6qyqXqMxQjpCjMp3Fc/EqgEQZLCtewp9ZRIl3zr71e43NU0J6IEnaKHBATKSCEgp3/T8H3vqyZ0NO85pSzWiYUd9G7r69p0lKuBtnxYsEVttE7nXVfVfnzbl2lHNUdxyemNyYE6fNEA0LMKos8kbdxvmU5l/B9i7siJJxIU8RhpvcFFRneXq+ZwSklW05+lOGyveSx0mYjRY161WBLTGErWRLcewrfBSOAm7rTnvuoRdEQLBm/DUPfXKVqSuD7OOEazdI5oKh1z9uUQJE3fKjfkV9HlZi4qqAGKRPIgOaE/E0g/tRlzeV0ROrGv9bLsGm9J2BzzjxWZxPjfSbOhiyPVqYI2LbBPN7HfoBO6hg+ABY52a6bwDvbdJB59Kuv4yzkI5wbOyA/ZneQdIID8mOKIIxeJkuCRL6HRmKEDcsHQ5T1BMqIlPO9AyOYltw2QetFyh4yfQY08NQ6UkzLcKAneu4uaMLp5OTODNvEQ8J18+ujZ0DvP0DVKSEay3/+0aEfDTsSVxo93Mmp/g/t3XRo9a/CpAdYj6rlBkHCR2JBwLoGkdfovZny6BEI/PCbfuqtZw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4791.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(346002)(376002)(396003)(136003)(366004)(39850400004)(451199018)(38100700002)(122000001)(2906002)(36756003)(15650500001)(478600001)(6486002)(71200400001)(26005)(1076003)(86362001)(41300700001)(6506007)(6512007)(186003)(38070700005)(83380400001)(2616005)(316002)(5660300002)(8936002)(64756008)(66446008)(76116006)(66476007)(8676002)(6916009)(66946007)(66556008)(4326008)(54906003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VWltc3lBM08xQzNLNXZXelc2OTB4a21jVVBkRkhJVU9MOXJBaFRaWUhQbGx6?=
 =?utf-8?B?U1ZJajd0anVuNzhEeWpPMUcyQk1kZG8xQ3kzd1R2ZXMyR0lwRzE1Ulc2YkhY?=
 =?utf-8?B?bHNMUEdxTU9VWXI0VVJSKzFLTFBPKzFESVJmMHN2ejRNdlhVM3cvSjVLMnhk?=
 =?utf-8?B?andhdklUenBFNGk5K0szWlVzcmE0bjhaUXc1bHA3SXYzcm1ERC9WMExaU0NP?=
 =?utf-8?B?ekxSclBQbm9ZRE52TnNRenYwbnNrN2lWNkw4a1J3R0xjcHVzZXl4RC9SdFhp?=
 =?utf-8?B?V0lpQjg2eExtUDE0L2NOYlFpZ1ZMYVBWQ1p6dTZrcERRQlpXalByVmpDTmhU?=
 =?utf-8?B?YWpMMFpqTzV5QnBaUFJwcUg2b0hZMWdwc053SVpPaDl2NXd2YlVZWnl5WTJl?=
 =?utf-8?B?M1plOWNCNGFRaTIxMHo2Si9Kb3o1cnBFYUIyNjFwM0pvTkUzTm9WaEVTSjBo?=
 =?utf-8?B?RlZ1aThzdGV4UGdQeWtYdVBWUHd4bS95MCtreGhQcmNIWVR0TnpsVzZxTlov?=
 =?utf-8?B?a3NFcUI2aU5uRk10M0txUzlCeGxGWk5ld3J6N2JCczdCWXBvR1NkWTdEbzdK?=
 =?utf-8?B?V3BNL29qTXJrMVNMcS9RRFpxcVJ2VmRrVnJKSDJHdUE3Qm1aZEJRUll5OTVo?=
 =?utf-8?B?ZFRjaU5qbzhiYSt6bW8rVVFFYmZPVkRSSTJiUm1EYWtZdk9xTFk4TFpVcm5Y?=
 =?utf-8?B?OHV5WXFicys3dHloZTJrejc0WEliUUpMNkhkRllHWGdKamYwWHpNczlhM2Qx?=
 =?utf-8?B?UXUzc09sNGlLaG1zWk9FeUpQcjdiVDhxdnZTb1pndk9ia2QvaHJtcWlDTGx2?=
 =?utf-8?B?eU1lek9yaklBMzJzR3BZUWJYOXdUYnQrYVNGQndiOVhSUUUyK1BHR3psem1h?=
 =?utf-8?B?ZXR1aldub2hTai9iTDZmU1RWazFTWCtXRG04c0pOWlluOTNLaEtkMjcvWTZM?=
 =?utf-8?B?TnJuNHRXdXp3RDhzVVcwVUNGQ0tLejUzdHltRnFIWStKcFhGZ0o0UTJsUXl4?=
 =?utf-8?B?MmlEaGJJYngvNWlpZDlXUTl4OWFnVUVMalArNGhsVDJUK1JGNG9JSnNsRmc2?=
 =?utf-8?B?STRoUGRhNUdka3VDZmQwVGVQRHRIRTN6VDk3TENKazUrZWFGZWZHalN0a3I2?=
 =?utf-8?B?WmpEUzNzNHBob25KelpManBDSHp6ZEJla2dYZkpuWk1aN3dwNVMxUHZPTmJo?=
 =?utf-8?B?ci96SW9xdWE0Nm1jZi8zd2tTb1gxME5WeExwNTk0U1p6VGo0YkhnWi94L1VT?=
 =?utf-8?B?WmJ5WmNmblhoVnNPa1BMSFdiZGdwbHR1ZWRaU29EL1JPVGVGUkdFY2FKR0xp?=
 =?utf-8?B?Vkg0QmpBSnJDU2VxdmpVb1NjbWJqMDAzVTQrSHlNemxpRTlwMVlETzlYaTNM?=
 =?utf-8?B?VG5lUjZNY05WaWNnTFVQVi9KTlhEZHNEL2MvQ3NwSjcwMjdtM1Fva2RZTThN?=
 =?utf-8?B?S1Q5VWFOM0ZLY1RzUGdvbE4xSzZBQStRNHFnSGlTR09qcy9kTmNUV25xZ1NG?=
 =?utf-8?B?ZHExYnNUSHZnbExwQXk0OUFUMVVQSmk2d1VkZ3hmZXFmb0Z5bFAzdkZiT0pa?=
 =?utf-8?B?SDVWVlpOZDlLU3dzOEp5cUdUSUl1ZDB2R1RGL0Q3ZWVTV0FCTmFrWno1aGpL?=
 =?utf-8?B?V1RiTjNyWmdPK2ZtdEt0czlkRTVEeGdNNHNkY1Y3bGcrSDhVYnQ3TVBPSnNx?=
 =?utf-8?B?U05ycW5uRUE2UkFqRkpiZ09JeDhFWGtHN3lMa3VOMjJGOWhvSG0wdHhqNytS?=
 =?utf-8?B?Njc2eEpycGc5ZjUwSTJ1anRyRWhrSm1zQnJKbml0TThVaE5WcVFDaEZzc2tJ?=
 =?utf-8?B?VklVa1RDRnlML2c0R3RNSzZWRVRhb3JJcC81VGdaY2t6RUdsSWdib1g1TG4z?=
 =?utf-8?B?T0hEMjYyaFlIS3hKZ290VUZaNW9NMkV3TEV2MmtjMVpNL3VySkpzME9YblZz?=
 =?utf-8?B?eHFoeHZxOFJ1WTkwa3IwRXAvQTd6UXorOGVrcDdaOEFqdWxWSGowMTU1b1RE?=
 =?utf-8?B?b1ZCZU85Y2Q3WVp6ajJFajFxSzhWRFBiQ0hydllNZ1dzODF5T0cyL3RXaW5a?=
 =?utf-8?B?RTkwNkkxeUswdk1FZjJjQnlMNWduamhkMXNxSXRDUk1MUlg0NlpsR0tqMmZq?=
 =?utf-8?B?U3lScE1EOGVyNkV6em9neTdDRGQ1RjJ2UzI2SGthSVByYThxOUZvaFl3SFg5?=
 =?utf-8?B?ckE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <DE7C0B1975767A4E95CAADC2227889D4@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 5pRfM7RfLVF7ahE7bWnsTs0EjgNZ6FXL92STkX0xm3QgnOyQxJGIbffe2GxXc1d5U4QI24O7svKjtqbIq4ZCricDzRdIB1wlrskpLNZoOOSkbELSvNLYnt9NoWoeVCJEdZ0gh/KqavzGlXAU0OTfxAjJ2t0DytXCzvqM2cuLlFMgz3WwtVtwhSX3ZxTYRu3vzPTa8wLiUr7xpyWKaplvHnbIPPo4pTFAkYpXdAEXYcNz0VYi0GqXQ6ojHjSfKamsN7qiL9jmBIVQsX299r16SCuKpTC4zVVRA/eBv6gpLRxPZP7N1GzyX4lPi8uoWaUGcRv2u4fbj7Yb2O2kgiBvLgcPqlBmA6NbwUFSo7m6+U/+kGWeHIFcv+Bh115HyG+mXI9qGLkRE4FA27GmhbnDn+j/hWJ5aJJjIzQ5/QE3u4pydjNK3xcYlE1SOhr6rV0sv+nnqRsYaNgvxI1eEZ7iz8N/xkOspShphBlMmwmozxdj+eXhPBFjn8eoCRXU8GQQ/FejWgU3k2vcfTrCRem9PqONETyU6bgztNoYqQDQyZAW9YNUzIGCu7Sgxo0QRZTqGwCFxYeJHR+lGmd/Oo5Px7KZ5y+pcmMW85N61WRnaJdnYRAyRRQ1JiIB4LtkmGBzyyre/xdnd0NM3DhB6tUHBe7NIPj71nGb1EZeuvckJkT4krEVoH9XB1hkI0lBKI+pZwbVZh7pkG7tcTbrVsSvQ3QFfrmoYuUnVMx9EhruSUhRJJVwFVCVoWgeIAt6fR1UCbKg/UeUKcD4iSmCZ8bfeLT0uWccpdzGfgIzxD8ranEA0YpuX0qTkkgCI3jlsKgN0tsiZe+86u29V7Wtfe5TH6M1p020UuF+NYc7b/VhPnQY0faS+KOguhj+aOoAeLIX7hLGwHJqYKxrAfMtuK6BvZM76eGMxRnoxFeynIyn+rw=
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4791.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 220f9457-4bc8-495d-fa47-08db08aa0a9b
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Feb 2023 01:24:21.7889
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: idNsfReCKlvJzkjjJ+Yd/PB7OMrG0kGiPHLjUoYoqvDGzWj/OurP45s/2Aqq98zwsgVP99yWOSCw+fNnhugXbw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4052
X-Proofpoint-GUID: uYqAsz4MzlQOpkXmsFHZAdP8EAJ0vmPW
X-Proofpoint-ORIG-GUID: uYqAsz4MzlQOpkXmsFHZAdP8EAJ0vmPW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-02-06_07,2023-02-06_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 spamscore=0 malwarescore=0 mlxscore=0 suspectscore=0 bulkscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 mlxlogscore=910
 priorityscore=1501 adultscore=0 phishscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2302070010
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgRWxzb24sDQoNCk9uIE1vbiwgRmViIDA2LCAyMDIzLCBFbHNvbiBSb3kgU2VycmFvIHdyb3Rl
Og0KPiBDaGFuZ2VzIGluIHYzDQo+ICAtIE1vZGlmaWVkIHJ3X2NhcGFibGUgZmxhZyB0byByZWZs
ZWN0IHRoZSBnYWRnZXRzIGNhcGFiaWxpdHkgZm9yIHdha2V1cA0KPiAgICBzaWduYWxsaW5nLg0K
PiAgLSBBZGRlZCBhIGNoZWNrIHRvIGNvbmZpZ3VyZSB3YWtldXAgYml0IGluIGJtQXR0cmlidXRl
cyBvbmx5IGlmIGdhZGdldA0KPiAgICBpcyBjYXBhYmxlIG9mIHRyaWdnZXJpbmcgd2FrZXVwLg0K
PiAgLSBJbXBsZW1lbnRlZCBhIGdhZGdldCBvcCBmb3IgY29tcG9zaXRlIGxheWVyIHRvIGluZm9y
bSBVREMgd2hldGhlciBkZXZpY2UNCj4gICAgaXMgY29uZmlndXJlZCBmb3IgcmVtb3RlIHdha2V1
cC4NCj4gIC0gQWRkZWQgYSBjaGVjayBpbiBfX3VzYl9nYWRnZXRfd2FrZXVwKCkgQVBJIHRvIHRy
aWdnZXIgd2FrZXVwIG9ubHkgaWYgdGhlDQo+ICAgIGRldmljZSBpcyBjb25maWd1cmVkIGZvciBp
dC4NCj4gIC0gQ29zbWV0aWMgY2hhbmdlcyBpbiBkd2MzX2dhZGdldF9mdW5jX3dha2V1cCgpIEFQ
SS4NCj4gDQo+IENoYW5nZXMgaW4gdjINCj4gIC0gQWRkZWQgYSBmbGFnIHRvIGluZGljYXRlIHdo
ZXRoZXIgdGhlIGRldmljZSBpcyByZW1vdGUgd2FrZXVwIGNhcGFibGUuDQo+ICAtIEFkZGVkIGFu
IGFzeW5jIHBhcmFtZXRlciB0byBfZHdjM19nYWRnZXRfd2FrZXVwKCkgQVBJIGFuZCBmZXcgY29z
bWV0aWMNCj4gICAgY2hhbmdlcy4NCj4gIC0gQWRkZWQgZmxhZ3MgdG8gcmVmbGVjdCB0aGUgc3Rh
dGUgb2YgIGZ1bmN0aW9uIHN1c3BlbmQgYW5kIGZ1bmN0aW9uIHJlbW90ZQ0KPiAgICB3YWtldXAg
dG8gdXNiX2Z1bmN0aW9uIHN0cnVjdCByYXRoZXIgdGhhbiBmdW5jdGlvbiBzcGVjaWZpYyBzdHJ1
Y3QgKGZfZWNtKS4NCj4gIC0gQ2hhbmdlZCB0aGUgZHdjM19nYWRnZXRfZnVuY19fd2FrZXVwKCkg
QVBJIHRvIHJ1biBzeW5jaHJvbm91c2x5IGJ5IGZpcnN0DQo+ICAgIGNoZWNraW5nIHRoZSBsaW5r
IHN0YXRlIGFuZCB0aGVuIHNlbmRpbmcgdGhlIGRldmljZSBub3RpZmljYXRpb24uIEFsc28NCj4g
ICAgYWRkZWQgZGVidWcgbG9nIGZvciBERVZJQ0VfTk9USUZJQ0FUSU9OIGdlbmVyaWMgY21kLg0K
PiAgLSBBZGRlZCBjaGFuZ2VzIHRvIGFybSB0aGUgZGV2aWNlIGZvciByZW1vdGV3YWtldXAvZnVu
Y3Rpb24gcmVtb3Rld2FrZXVwDQo+ICAgIG9ubHkgaWYgZGV2aWNlIGlzIGNhcGFibGUuDQo+IA0K
PiBBbiB1c2IgZGV2aWNlIGNhbiBpbml0YXRlIGEgcmVtb3RlIHdha2V1cCBhbmQgYnJpbmcgdGhl
IGxpbmsgb3V0IG9mDQo+IHN1c3BlbmQgYXMgZGljdGF0ZWQgYnkgdGhlIERFVklDRV9SRU1PVEVf
V0FLRVVQIGZlYXR1cmUgc2VsZWN0b3IuDQo+IFRvIGFjaGlldmUgdGhpcyBhbiBpbnRlcmZhY2Ug
Y2FuIGludm9rZSBnYWRnZXRfd2FrZXVwIG9wIGFuZCB3YWl0IGZvciB0aGUNCj4gZGV2aWNlIHRv
IGNvbWUgb3V0IG9mIExQTS4gQnV0IHRoZSBjdXJyZW50IHBvbGxpbmcgYmFzZWQgaW1wbGVtZW50
YXRpb24NCj4gZmFpbHMgaWYgdGhlIGhvc3QgdGFrZXMgYSBsb25nIHRpbWUgdG8gZHJpdmUgdGhl
IHJlc3VtZSBzaWduYWxpbmcgc3BlY2lhbGx5DQo+IGluIGhpZ2ggc3BlZWQgY2FwYWJsZSBkZXZp
Y2VzLiBTd2l0Y2hpbmcgdG8gYW4gaW50ZXJydXB0IGJhc2VkIGFwcHJvYWNoIGlzDQo+IG1vcmUg
cm9idXN0IGFuZCBlZmZpY2llbnQuIFRoaXMgY2FuIGJlIGxldmVyYWdlZCBieSBlbmFibGluZyBs
aW5rIHN0YXR1cw0KPiBjaGFuZ2UgZXZlbnRzIGFuZCB0cmlnZ2VyaW5nIGEgZ2FkZ2V0IHJlc3Vt
ZSB3aGVuIHRoZSBsaW5rIGNvbWVzIHRvIGFjdGl2ZQ0KPiBzdGF0ZS4NCj4gDQo+IElmIHRoZSBk
ZXZpY2UgaXMgZW5oYW5jZWQgc3VwZXItc3BlZWQgY2FwYWJsZSwgaW5kaXZpZHVhbCBpbnRlcmZh
Y2VzIGNhbg0KPiBhbHNvIGJlIHB1dCBpbnRvIHN1c3BlbmQgc3RhdGUuIEFuIGludGVyZmFjZSBj
YW4gYmUgaW4gZnVuY3Rpb24gc3VzcGVuZA0KPiBzdGF0ZSBldmVuIHdoZW4gdGhlIGRldmljZSBp
cyBub3QgaW4gc3VzcGVuZCBzdGF0ZS4gRnVuY3Rpb24gc3VzcGVuZCBzdGF0ZQ0KPiBpcyByZXRh
aW5lZCB0aHJvdWdob3V0IHRoZSBkZXZpY2Ugc3VzcGVuZCBlbnRyeSBhbmQgZXhpdCBwcm9jZXNz
Lg0KPiBBIGZ1bmN0aW9uIGNhbiBiZSBwdXQgdG8gZnVuY3Rpb24gc3VzcGVuZCB0aHJvdWdoIEZV
TkNUSU9OX1NVU1BFTkQgZmVhdHVyZQ0KPiBzZWxlY3RvciBzZW50IGJ5IHRoZSBob3N0LiBUaGlz
IHNldHVwIHBhY2tldCBhbHNvIGRlY2lkZXMgd2hldGhlciB0aGF0DQo+IGZ1bmN0aW9uIGlzIGNh
cGFibGUgb2YgaW5pdGlhdGluZyBhIGZ1bmN0aW9uIHJlbW90ZSB3YWtldXAuIFdoZW4gdGhlDQo+
IGZ1bmN0aW9uIHNlbmRzIGEgd2FrZXVwIG5vdGlmaWNhdGlvbiB0byB0aGUgaG9zdCB0aGUgbGlu
ayBtdXN0IGJlIGZpcnN0DQo+IGJyb3VnaHQgdG8gYSBub24tVTAgc3RhdGUgYW5kIHRoZW4gdGhp
cyBub3RpZmljYXRpb24gaXMgc2VudC4NCj4gDQo+IFRoaXMgY2hhbmdlIGFkZHMgdGhlIGluZnJh
c3RydWN0dXJlIG5lZWRlZCB0byBzdXBwb3J0IHRoZSBhYm92ZQ0KPiBmdW5jdGlvbmFsaXRpZXMu
DQo+IA0KPiBFbHNvbiBSb3kgU2VycmFvICg1KToNCj4gICB1c2I6IGdhZGdldDogUHJvcGVybHkg
Y29uZmlndXJlIHRoZSBkZXZpY2UgZm9yIHJlbW90ZSB3YWtldXANCj4gICB1c2I6IGR3YzM6IEFk
ZCByZW1vdGUgd2FrZXVwIGhhbmRsaW5nDQo+ICAgdXNiOiBnYWRnZXQ6IEFkZCBmdW5jdGlvbiB3
YWtldXAgc3VwcG9ydA0KPiAgIHVzYjogZHdjMzogQWRkIGZ1bmN0aW9uIHN1c3BlbmQgYW5kIGZ1
bmN0aW9uIHdha2V1cCBzdXBwb3J0DQo+ICAgdXNiOiBnYWRnZXQ6IGZfZWNtOiBBZGQgc3VzcGVu
ZC9yZXN1bWUgYW5kIHJlbW90ZSB3YWtldXAgc3VwcG9ydA0KPiANCj4gIGRyaXZlcnMvdXNiL2R3
YzMvY29yZS5oICAgICAgICAgICAgICAgfCAgIDUgKysNCj4gIGRyaXZlcnMvdXNiL2R3YzMvZGVi
dWcuaCAgICAgICAgICAgICAgfCAgIDIgKw0KPiAgZHJpdmVycy91c2IvZHdjMy9lcDAuYyAgICAg
ICAgICAgICAgICB8ICAxNiArKy0tLQ0KPiAgZHJpdmVycy91c2IvZHdjMy9nYWRnZXQuYyAgICAg
ICAgICAgICB8IDExMCArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrLS0tDQo+ICBkcml2
ZXJzL3VzYi9nYWRnZXQvY29tcG9zaXRlLmMgICAgICAgIHwgIDUwICsrKysrKysrKysrKysrKy0N
Cj4gIGRyaXZlcnMvdXNiL2dhZGdldC9mdW5jdGlvbi9mX2VjbS5jICAgfCAgNjggKysrKysrKysr
KysrKysrKysrKysrDQo+ICBkcml2ZXJzL3VzYi9nYWRnZXQvZnVuY3Rpb24vdV9ldGhlci5jIHwg
IDYzICsrKysrKysrKysrKysrKysrKysNCj4gIGRyaXZlcnMvdXNiL2dhZGdldC9mdW5jdGlvbi91
X2V0aGVyLmggfCAgIDQgKysNCj4gIGRyaXZlcnMvdXNiL2dhZGdldC91ZGMvY29yZS5jICAgICAg
ICAgfCAgNDYgKysrKysrKysrKysrKysNCj4gIGRyaXZlcnMvdXNiL2dhZGdldC91ZGMvdHJhY2Uu
aCAgICAgICAgfCAgIDUgKysNCj4gIGluY2x1ZGUvbGludXgvdXNiL2NvbXBvc2l0ZS5oICAgICAg
ICAgfCAgIDYgKysNCj4gIGluY2x1ZGUvbGludXgvdXNiL2dhZGdldC5oICAgICAgICAgICAgfCAg
MTIgKysrKw0KPiAgMTIgZmlsZXMgY2hhbmdlZCwgMzcxIGluc2VydGlvbnMoKyksIDE2IGRlbGV0
aW9ucygtKQ0KPiANCj4gLS0gDQo+IDIuNy40DQo+IA0KDQpIaSBFbHNvbiwNCg0KVGhhbmtzIGZv
ciB5b3VyIHBhdGNoZXMhIEkgcHJvdmlkZWQgc29tZSBjb21tZW50cy4gSG9wZWZ1bGx5IHRoZXkg
Y2FuIGJlDQptZXJnZWQgc29vbi4NCg0KVGhhbmtzLA0KVGhpbmg=
