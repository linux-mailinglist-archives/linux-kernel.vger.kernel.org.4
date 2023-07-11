Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EE7C74FA2F
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 23:57:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231550AbjGKV5O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 17:57:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229868AbjGKV5M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 17:57:12 -0400
Received: from mx0a-00230701.pphosted.com (mx0a-00230701.pphosted.com [148.163.156.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 211E91704;
        Tue, 11 Jul 2023 14:57:11 -0700 (PDT)
Received: from pps.filterd (m0297266.ppops.net [127.0.0.1])
        by mx0a-00230701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36BKeQG4016085;
        Tue, 11 Jul 2023 14:56:57 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=pfptdkimsnps;
 bh=nwtjgZf3ZE1c3amYOvywBDfQb+v3c4pp/Qah5YR15JU=;
 b=Y55FZj00UpoYnUoFpDNtHT2eDBQTEjDX4VQdB1mCuDpEMgJtJdL1XRNEWSb75ZUfuRsd
 H/T+JzKYph2dcqdmegK9lE3PFS0rbAlFZaivTvAf+R2YDyFSH6TnE5ryw6e8LEw4YXjo
 krDBqS/Iyt71jE4g5aA21C7DUlIHEAlLNnaPezitg4rkyrMRIZIS0mX97AcwftJFTO9D
 fR8WNoArsdnQmzn3yARO1S0ueod4RjDNpi42gsILKzbJWJdOiiH0QThpVa8RIqzrOFpe
 bLs/gsGDTK6ltr2YXgMn4IIGoGNbqtJ7bgcvPI9rC4kzkHpqLOjJRjgghwMwinMNMXJU /Q== 
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.87.133])
        by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 3rq725nbm0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 11 Jul 2023 14:56:56 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1689112616; bh=nwtjgZf3ZE1c3amYOvywBDfQb+v3c4pp/Qah5YR15JU=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=JnixgENgitLts4ffNfHcW4Csxh+U1b2SQFdVkupvRIp7u0bBgNl+Pptimo17A3voE
         S32NZbRPP0Vk/E3aIzI9i+qjApe7OPt5YhG2s3seOPEgfo3KKy2J2uIz4/TWCU+Jec
         gakhrnvDQxYsE4JcAyOvGxMyeQrAqhqBwSKUziw8b0hAOqPv+w5nalY228nrG3EHP0
         xyrtcFjbARQP0zQSPSvmi7G2dbcJi53GAK+3RNUhyhZFGq/0X8x06B2AevG/uDvYlV
         1Q8QY7XmZ0nKY3RMPtPB/HVWIcXAh7tB0f6vuU2CopQHBk5qa7YPDfg0W7ZwCU2o5t
         8BsI6JnHh3Raw==
Received: from mailhost.synopsys.com (sv1-mailhost1.synopsys.com [10.205.2.131])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits)
         client-signature RSA-PSS (2048 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id A70004013F;
        Tue, 11 Jul 2023 21:56:55 +0000 (UTC)
Received: from o365relay-in.synopsys.com (sv2-o365relay3.synopsys.com [10.202.1.139])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
        by mailhost.synopsys.com (Postfix) with ESMTPS id BA9B6A024A;
        Tue, 11 Jul 2023 21:56:54 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=Y5g7ga35;
        dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2177.outbound.protection.outlook.com [104.47.55.177])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id 0EC7740359;
        Tue, 11 Jul 2023 21:56:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ihJZG8zgPFw+phbAr+MtztMEMrgVjWvetkYMfClawS0hmt23mMl13cS7Oxbo8N0pG1UmjmojkngMovulryecG6uVLE/JclOhgsYWDKExtbC8CGXh8+uBEw8eamDupLfz7skOl7MeJJuAwhAu87qdixwk64z2pswChoPx5jmYnpCRhL6PI4F0RZO3rfMfXRrTFxXGxC9EN71OQKCMR6BFn9pyrT7YzxIgoH5ZSN7BLhbgBo8q8oaj/6/MkK4YIHtdt4YF/MFRcC9vu7ytAqMnkLOwSj9UwQbG1PMK78C1poDG58dzQSxKMjk2uYb+v+EPiQwo0eRBFQuraroJsQEl/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nwtjgZf3ZE1c3amYOvywBDfQb+v3c4pp/Qah5YR15JU=;
 b=nS4KiGtDhREeTjN9m+SGgDcr7kvALctHrO4rNfW3P0PV4xEt9wJZHYOuVH6O06yW9k/q4B82e2EN6UvKxiavEdhlm+iJtlr6fij4aOhZFTrRRKkGz13omvjGoNV8a6/1DzCE9+0g6+wlrxW59hewqn/sH5vbOiVjD9McLl7/qx6XvPCd6VIzDTL/XWdzS0GLkPOmUmIKuAOuC0hnZe05JsHJG1+HBPVTDbJR2tMCs7EHufKXHDJff548JN6YaB5WJUJSULtcdm/OHR1qDAEQW9EHks0fG5CdZcI03HFgkXeQ9ph6Pbh9Qt17YG2Jy7axbOb6zDRS2gySiiYIUs3zvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nwtjgZf3ZE1c3amYOvywBDfQb+v3c4pp/Qah5YR15JU=;
 b=Y5g7ga35MlmbU5DrepWzDeNqonhH6+KbHjYHzy2Y7o/5wAf0Ye5E3EbCT24jdvMDluvDIONOlo4N9Cr15F6cSE5rmRUhE72+hECina9iaBBE5IpF26Tl0MfnDZ8p/I1oqP0CD+ZwmsJeQE8Oi9RHfhtRlx+JtLqqIx7A4wFYxoA=
Received: from BYAPR12MB4791.namprd12.prod.outlook.com (2603:10b6:a03:10a::12)
 by CY8PR12MB7562.namprd12.prod.outlook.com (2603:10b6:930:95::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.32; Tue, 11 Jul
 2023 21:56:48 +0000
Received: from BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::adba:1075:fd90:fe1d]) by BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::adba:1075:fd90:fe1d%3]) with mapi id 15.20.6565.028; Tue, 11 Jul 2023
 21:56:48 +0000
X-SNPS-Relay: synopsys.com
From:   Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To:     Elson Roy Serrao <quic_eserrao@quicinc.com>
CC:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        "stern@rowland.harvard.edu" <stern@rowland.harvard.edu>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "rogerq@kernel.org" <rogerq@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "quic_wcheng@quicinc.com" <quic_wcheng@quicinc.com>,
        "quic_jackp@quicinc.com" <quic_jackp@quicinc.com>
Subject: Re: [PATCH v3 2/3] dt-bindings: usb: snps,dwc3: Add
 allow-rtsusp-on-u3 property
Thread-Topic: [PATCH v3 2/3] dt-bindings: usb: snps,dwc3: Add
 allow-rtsusp-on-u3 property
Thread-Index: AQHZtB89tzIHlPHp90GZgxtzbuqKpq+1HOyA
Date:   Tue, 11 Jul 2023 21:56:48 +0000
Message-ID: <20230711215645.6wclz5uffqnlpnnd@synopsys.com>
References: <20230711174320.24058-1-quic_eserrao@quicinc.com>
 <20230711174320.24058-3-quic_eserrao@quicinc.com>
In-Reply-To: <20230711174320.24058-3-quic_eserrao@quicinc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR12MB4791:EE_|CY8PR12MB7562:EE_
x-ms-office365-filtering-correlation-id: d67ade4d-3f22-41bd-41a8-08db8259b9ac
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Un9LCm2KG5/fd+z2J+ziz//CXFE8STTMi0d1URHIIcc995pzaBydoFBN9lRNRV5ejM1VwXve9s1nrKx21frf7+f+yqteDfkVfD/eaGrrIXJt+o8gi+Smaz37NU104rW4yNZ8ku1bJGaQzktZXPf03tjSCzJuZSoAPoFq8yIZLzRwWc4bkzADkHHDgHZC39PeMpPi1eH5yRtqGSSTXbz5TsOgOb9hTSs1qG/W1RMzSQDtZJsHQ3fhW1vFMe0+FEdIfeqytUJR+EZQkJIhbotH+O3aA4sh4+EQ9gte3Gyk8jMpvitppMAE5jMM+2bciWVCq3Kl83bJX36YKTpyoTwFCJaUEGj5rMot2rPJBbygPoHz/CrzRqK5A+fo8mvZulBd9f4sgC1kW6mChvkTnKCIra9EZABVDCHenz6Jz9PzYIuvrTyzqPKnBiZ4fJcuAPQ64uxq4+LO7Fm8wfRTgYj6k2ULA0eWqP8O/S5ufS+CdDB+QNgmd8TvoioObuYzco3ql/nwcYJGpta/Vqx9mKIO4K86bc9G9Qnl+tubF08aiQCshBhVyj3GKRE9FmsnGLHg6NViv9FaLL25JoAQU+0pmIq2Zc50aOyDXdLTIWLDBbScdD1MOXXekE+/aEmxN0g8
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4791.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(346002)(136003)(366004)(39860400002)(376002)(451199021)(6486002)(6916009)(4326008)(66476007)(66946007)(76116006)(66556008)(64756008)(66446008)(478600001)(26005)(1076003)(6506007)(122000001)(38100700002)(54906003)(71200400001)(316002)(41300700001)(6512007)(38070700005)(8676002)(8936002)(86362001)(5660300002)(186003)(83380400001)(2616005)(2906002)(36756003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dE1rWUlzdk9tZ2pSZmlBdTNOdXZKUitUbUtIanM4Z1lrM1YyeUVFSk0xZ051?=
 =?utf-8?B?dGNoQ1BZVkozS2xpYnovems1YWZyUGJ5SVFoQmhmV1Rsb0tzUUc4NDZaV2lW?=
 =?utf-8?B?Uy9uUXJWbW53QTg4b1NFNVdSUlp6RWFhSDhNUVRXbDRLenN1U3dEb0g3L2tD?=
 =?utf-8?B?c0Y1bUZyQjlUUHlVRWVYbXhsVjBqSE1SUGFrWnplaTlLNXB2ZHpheGpPNENw?=
 =?utf-8?B?U1MxRXM4ZzN3d05tL2d4b0JsNUdYQVhoalJPOTViak40OUZudXFxekQ0MnN5?=
 =?utf-8?B?eU1kZVo4S3MrL0ZnOHVNRHF6T1NVSGdCTkdsU0NIMnZkZXI4ZEFYdHhLNmtF?=
 =?utf-8?B?NTdDb04zRXpXSmFtVmRYbHI5ZUMxdWtqTTRrUEJabkdFc0RlZzRULzZpaXIz?=
 =?utf-8?B?bHNMRC94cDNpN1FZU1pFcXhGVWNaYTYwaWRxUTN3bkkzSVp2RHdId2JMVnFt?=
 =?utf-8?B?Qmtlc2tUQm5ETDd1Q3BWT3NKYlEwTzYweFh3eUJsRGkvUjlVdmlGc0g2TkdU?=
 =?utf-8?B?ZXQ4ZGk3b09xa2Y5S3ZMeGc1UWJzdWx6NFBEZmFLcEUrZk1vV3RWcThRMXo2?=
 =?utf-8?B?UGUvRWtnS01haUVLQVJyMzh6bksyTHI0M0tUVzFtSnc2OTd2ZWtGZnFpdFJK?=
 =?utf-8?B?REVDK2xiNTlwNjBKTjNoY2FFWmhyeEk0bTJ5OWk0cnljbXZIU2lGTWNSTzJH?=
 =?utf-8?B?cnIwUE1rRXJiLzVnR3pZQUpWL0hBSmlhRXZnZW9ZSUlURVZXM0ZWTFUrdW5I?=
 =?utf-8?B?RFJHVS80WUxSNC8rZDZCeWJrUzNaVndHa0tTclh6a3lsbElycVpaUjJTR1FE?=
 =?utf-8?B?ZGpBMHJGOFFjdEhxckNNTDFaSVEwdk9YTm9tRFBST21XVFhTUWk5dlpJclpq?=
 =?utf-8?B?Z2VaUUpxalBlbmlDUEpwYld3TmlpamRQM1JmdlpiaGZTaXNqcGF4bXpNSFB1?=
 =?utf-8?B?SVhjWVE0Y3BFamxzV1hZbDdVeW90a3ZrVHNvRjZwS2MrejZ3SGtmSXJxUldD?=
 =?utf-8?B?TmIvVmsxSnRpc05QS3ZpQ3JKbnFpVWU5bEc3VDBrMnZuTDl2Rkt1YmlxRFpm?=
 =?utf-8?B?b2NIMVh5MVhZaDFnMTJDSURzYUtvaitMMWszMlVidzFHZTFFeU9VTVNwOFJ3?=
 =?utf-8?B?NmNuN2RsVXRnb1dwQUdpV3ZIY3dwOVMvQkRvV2ZadnNHRzZ5ME95QWFDWUt0?=
 =?utf-8?B?TFFuTUlQMGtJZ0w0SmJ5Qk9KdmFmc0doUDQ0aVhMVlB5THZsYVRrSFhjZjN4?=
 =?utf-8?B?RjVoa2xLM1NhM2xBVlNQYXpwWjY3WVozZU80YmFRVkZodkhUQXV6ZS9mVWVp?=
 =?utf-8?B?eGZmRlRHWU1YU0Qwa2pYNHpHTXM3WldmU3FGb2NpNWlWYUZmdWVSSjhBQjE1?=
 =?utf-8?B?RGhxUHJhNERaN2RKSGlUS3BkR1FKMjY4N1NBeFNIc1ljbkN5YU4vSWxlQXpj?=
 =?utf-8?B?UGkxRzRZZHN2MEN1Nk4rZkQrcTgyUFdUV0FWcG9JMkx5VzVTWEpnQ1RqTGhX?=
 =?utf-8?B?Vm00NXpyNmNpQ29ydWkxbjRudVNrY2FqSDc2WU1USS8yeUYzVVFVTmUxN0tV?=
 =?utf-8?B?NHloZTR3bVA2SG5Da1ZwcVFJQ3N5NVgyY3g1QVN3cXRXMUd6VmowR0tQZng5?=
 =?utf-8?B?R2Z6R0VIdkZiQzB0c094NGgrR3YzVC8yVitaZ1Nza2plc0lEQVE4ckdWelBo?=
 =?utf-8?B?ZSsrVlJZMjZwWDV6YnlJYnFGekdKSys4eGlvZ2pTa3R5d1I4TEl0UHVhUk9s?=
 =?utf-8?B?a0V2YzlhWkprSEw1bFpialg1WHVlNEhJWFVKY3NsVHdMYUladHBIOE0wUVd5?=
 =?utf-8?B?T1k3ZHVmbWQvemk4NTgyYy9VRm0rL3JSekxuNkRyMnBubGFQa0FKdDZTS3VQ?=
 =?utf-8?B?MCtFK2JzQU1aeUJtQXhOTG41cTE5ZnpFR0dKd25TOVdZWDJWWnA3UEhzRDJl?=
 =?utf-8?B?blc3TlZWVlluSWhGcFBRTUxyMUJkcHhnWVRLdVVORDlIOG5SS21ZV2h4Kzg5?=
 =?utf-8?B?UlI1VHpmUjJxUTNNZnZVV21nWjJxMkxYdlpZZHhLWFZQM3lLSjRyL2dhTU8r?=
 =?utf-8?B?M0dtL2xZQXpQZEw2bVdaVWE4ckdacXRTczF2aURKUm5QYzVaQ1dweDlmaEhs?=
 =?utf-8?B?TDQwclFYcHEvRTR2azhSY3IrQlN4WnJsNEVSbm4rVklwc0ZQYlRsZld4L1pN?=
 =?utf-8?B?eXc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <133EB83E8CC2B74AAFDA2852FB4C121F@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?UWRiUTh4bVdNTURoYkFGZGwyODNqaXRRWGp3NEFnR3pwSDFZZ2xyYVZVcDUz?=
 =?utf-8?B?NWJhU3kzS2tzM2xDMmRMZGxHN0pRcWhvZzQxNVVFVEhFWjh6TEdubVZESzVw?=
 =?utf-8?B?am9pcWtCcU9NZ3pUWWRRd2hsYmJaY1VtdS94c0d4dFVvQzZXd3B0TmRDUnhj?=
 =?utf-8?B?K2NhQm96NHIwMitMZm9sQzlyUURxbVpwM3pZeTNoSkRkSGJNb1hJWVpvWkRp?=
 =?utf-8?B?WmxkOW5YTUJ0VXQ5UTVhZU1ZWDg5bG4wUWFhWkpVMTFhSzB6UWIva1NPd0ha?=
 =?utf-8?B?TGF3aHcvcjJ0Q2YxVVZjMmtKZ0RqNVJwQzNJTkl0VjZ0OEsrcEhoS25LNEdV?=
 =?utf-8?B?Y0V4Z3hROGZtclpKeHZBTS9XbWVjcEkyRXlRYlNLblJzRGZVczdSYmlibmx0?=
 =?utf-8?B?d3dGVmFaNHN0U2VMYjFCYU9ESEI1OGhQeXprWmNGYU9rRXpNU2w2NE9Xb1pX?=
 =?utf-8?B?TG5IN2RkeGQ0ZVB1dVR6cXpJdHR0bURzNmtIdHBjbGdXZWo0aGlNWFBnSWo4?=
 =?utf-8?B?TmZ4Yjh0K2FlVlJJdlhDVy90TldZSEpacmVFYmtIcjhNeXhvSTZpckRHdFdJ?=
 =?utf-8?B?dEp3MHV6dFlTZjFpOU50WmdXUmpaT2REUzZscXBsTHVMZ205RFgxYlJRMDd2?=
 =?utf-8?B?QjJKWFlEeHpKY1Y0Q29wNmpFL2FyMm54UmFVbm5STlAybUxsbytOU3dHTjNq?=
 =?utf-8?B?cFZ1dzZwYnVXbi9aSHNoQnZUMkJISTM2VStKTGJVajhaUmk5bjgvaDVBRG5W?=
 =?utf-8?B?S0UzV2UzVjZSSzBzK2w4MFVmVHdHcTgvalJuQ1o2TXE5ckZtV3d6N3owdVlF?=
 =?utf-8?B?Q3k4ZmJyY3dUSnRwUk9ZMnRqeHlqNHo1a08zd0t6eXF4MGhyREI4bi9OVUYw?=
 =?utf-8?B?MHNpbEEzNGF4NERHdEVKa0N4SmRvMU5qdjdNUlNZSDB5SjZJWUNMcVJQclZq?=
 =?utf-8?B?aks0eTZPRVFuMXFkNzdBd1J0cXNQTW80TjN5OXREUE05ZTcrTFFYb0lRV1BZ?=
 =?utf-8?B?akV1TDZ5UGRiV2NJVC9MSU8zdW1CaHNQQU5haDdoUGdXUGhkbjVMcGUyWE5P?=
 =?utf-8?B?bGxicGNLUjNLZ1N4SVBrNnRWblpYVEdlZmV3ZFFTTCtEOGlTcjdqNitSZWRx?=
 =?utf-8?B?NE4rVkJYZ0RkYXlQTkVGcWJzRmF2aFRhdmU1VkpOL3VxRFJUaHdJcFZlYWxT?=
 =?utf-8?B?bnNHcEtpVzVXSEw5ZFNhMDdxd1ArdnRZSzJ6Nk11bVBRenRSL2FhdFk0QVBj?=
 =?utf-8?B?S252Y1ROcVpnYmhQVkhoQmtKVlk2ck1MdTJNYjZmNXpkWENDZz09?=
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4791.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d67ade4d-3f22-41bd-41a8-08db8259b9ac
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jul 2023 21:56:48.1269
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LkbdJS9/+0vxFWBpzIOVc3YfGHPEQtja2ts47bJ2jCN3PVoiX3EmVNCb/XUW6lijwe7tRbI/GuwqNCXuppkmtQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7562
X-Proofpoint-ORIG-GUID: Hg7OqiWrIMRwxQVSPOnyx2bDAnbmc5E7
X-Proofpoint-GUID: Hg7OqiWrIMRwxQVSPOnyx2bDAnbmc5E7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-11_12,2023-07-11_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 bulkscore=0 clxscore=1011 priorityscore=1501 suspectscore=0
 mlxlogscore=420 phishscore=0 lowpriorityscore=0 impostorscore=0
 adultscore=0 spamscore=0 malwarescore=0 mlxscore=0 classifier=spam
 adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2307110199
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCBKdWwgMTEsIDIwMjMsIEVsc29uIFJveSBTZXJyYW8gd3JvdGU6DQo+IFRoaXMgcHJv
cGVydHkgYWxsb3dzIGR3YzMgcnVudGltZSBzdXNwZW5kIHdoZW4gYnVzIHN1c3BlbmQgaW50ZXJy
dXB0DQo+IGlzIHJlY2VpdmVkIGV2ZW4gd2l0aCBjYWJsZSBjb25uZWN0ZWQuIFRoaXMgd291bGQg
YWxsb3cgdGhlIGR3YzMNCj4gY29udHJvbGxlciB0byBlbnRlciBsb3cgcG93ZXIgbW9kZSBkdXJp
bmcgYnVzIHN1c3BlbmQgc2NlbmFyaW8uDQo+IA0KPiBUaGlzIHByb3BlcnR5IHdvdWxkIHBhcnRp
Y3VsYXJseSBiZW5lZml0IGR3YzMgSVBzIHdoZXJlIGhpYmVybmF0aW9uIGlzDQo+IG5vdCBlbmFi
bGVkIGFuZCB0aGUgZHdjMyBsb3cgcG93ZXIgbW9kZSBlbnRyeS9leGl0IGlzIGhhbmRsZWQgYnkg
dGhlDQo+IGdsdWUgZHJpdmVyLiBUaGUgYXNzdW1wdGlvbiBoZXJlIGlzIHRoYXQgdGhlIHBsYXRm
b3JtIHVzaW5nIHRoaXMgZHQNCj4gcHJvcGVydHkgaXMgY2FwYWJsZSBvZiBkZXRlY3RpbmcgcmVz
dW1lIGV2ZW50cyB0byBicmluZyB0aGUgY29udHJvbGxlcg0KPiBvdXQgb2Ygc3VzcGVuZC4NCj4g
DQo+IFNpZ25lZC1vZmYtYnk6IEVsc29uIFJveSBTZXJyYW8gPHF1aWNfZXNlcnJhb0BxdWljaW5j
LmNvbT4NCj4gLS0tDQo+ICBEb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvdXNiL3Nu
cHMsZHdjMy55YW1sIHwgNSArKysrKw0KPiAgMSBmaWxlIGNoYW5nZWQsIDUgaW5zZXJ0aW9ucygr
KQ0KPiANCj4gZGlmZiAtLWdpdCBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy91
c2Ivc25wcyxkd2MzLnlhbWwgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvdXNi
L3NucHMsZHdjMy55YW1sDQo+IGluZGV4IGE2OTZmMjM3MzBkMy4uMThhZDk5YTI2ZGQ5IDEwMDY0
NA0KPiAtLS0gYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvdXNiL3NucHMsZHdj
My55YW1sDQo+ICsrKyBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy91c2Ivc25w
cyxkd2MzLnlhbWwNCj4gQEAgLTQwMyw2ICs0MDMsMTEgQEAgcHJvcGVydGllczoNCj4gICAgICBk
ZXNjcmlwdGlvbjoNCj4gICAgICAgIEVuYWJsZSBVU0IgcmVtb3RlIHdha2V1cC4NCj4gIA0KPiAr
ICBzbnBzLGFsbG93LXJ0c3VzcC1vbi11MzoNCg0KUGxlYXNlIHNwZWxsIG91dCB0aGUgd2hvbGUg
dGhpbmcgYXMgInJ0c3VzcCIgaXNuJ3QgY2xlYXIuIEFsc28sIGl0J3Mgbm90DQpqdXN0IGZvciBV
MyByaWdodD8gRm9yIGhpZ2hzcGVlZCwgaXQncyBMMi4NCg0KSG93IGFib3V0IHRoZSBuYW1lIHRo
YXQgUm9nZXIgdXNlOiAic25wcyxnYWRnZXQta2VlcC1jb25uZWN0LXN5cy1zbGVlcCINCg0KPiAr
ICAgIGRlc2NyaXB0aW9uOg0KPiArICAgICAgSWYgVHJ1ZSB0aGVuIGR3YzMgcnVudGltZSBzdXNw
ZW5kIGlzIGFsbG93ZWQgZHVyaW5nIGJ1cyBzdXNwZW5kDQo+ICsgICAgICBjYXNlIGV2ZW4gd2l0
aCB0aGUgVVNCIGNhYmxlIGNvbm5lY3RlZC4NCj4gKw0KPiAgdW5ldmFsdWF0ZWRQcm9wZXJ0aWVz
OiBmYWxzZQ0KPiAgDQo+ICByZXF1aXJlZDoNCj4gLS0gDQo+IDIuMTcuMQ0KPiANCg0KRGlkIHlv
dSBDYyBSb2IsIHRoZSBkZXZpY2V0cmVlIG1haW50YWluZXI/DQoNClRoYW5rcywNClRoaW5o
