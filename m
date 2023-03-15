Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DAA26BBEB9
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 22:16:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232791AbjCOVQa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 17:16:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232602AbjCOVQW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 17:16:22 -0400
Received: from mx0a-00230701.pphosted.com (mx0a-00230701.pphosted.com [148.163.156.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70C0CA2187;
        Wed, 15 Mar 2023 14:16:01 -0700 (PDT)
Received: from pps.filterd (m0098571.ppops.net [127.0.0.1])
        by mx0a-00230701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32FL5ehw028631;
        Wed, 15 Mar 2023 14:15:49 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=pfptdkimsnps;
 bh=9yzWLphrBJDofxAcqqUSerWWtrD9JeFA1lAeEYY/owg=;
 b=MA+K2B9G6tUxWuKxPAQKZ8IMus/wQQiPnUVabvG6iyS3VnauhuiYfulthpAgHyecgw+Z
 XcjiVHErB1j1+fGvQ8Xhzt9GDGaG8/IbxsPcwnVMSON27FIBJW54aHS8W2uHvOIr3jjs
 udNYw3QNXdC2OX9iEuvYTXOdtsWHqqmiuYeGzXxmnXfyAYo9bFcTgK2Gy5y/ybkrNDE9
 a6WVus+S6atKzywhnc6X/Wxb20lDCKf986j8URd+AXwjK1LvsqhYe4J561pfHgDOfcex
 HFA2xibnmKbKCBa+3RHXCy0E1BIhyHzUqKv9+kKTeY9h3Ao0zPvH/SIpy9LWTR6fmjl6 Ag== 
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.73.133])
        by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 3pbmvqr5uy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 15 Mar 2023 14:15:49 -0700
Received: from mailhost.synopsys.com (badc-mailhost3.synopsys.com [10.192.0.81])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id BC4234013D;
        Wed, 15 Mar 2023 21:15:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1678914949; bh=9yzWLphrBJDofxAcqqUSerWWtrD9JeFA1lAeEYY/owg=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=iGp9o1P4mm9HbvWl/Hyjno7e9FOfjh2GkCizuftI6vr8V1QbIyNUtvWRYteDEqsEU
         VFwz0wgzMJd8zCJWUvDCIH+p2+JHVqkK9CQFA1Qf8fl1TEqRTfquXZ9N0FvphkXiz2
         wn/nTSOmfix6SKyykq2oCQesR7roeXu8apfoeeihPpBCI5mc2re4MP/fAP4kMZnUio
         gSk8bJGPZ+l8u3vTfk2JzeeNRc2sby6RzaHm117Hr83KTNcCWUAo4Vx5Vxo8IIzQZN
         A8vw6cW+o9L32tz1jHkw+j4u6j9UGCAes/pdgmt3jkT+AuB8gPf0x1JaC1+M0hX4tG
         HWimeHyscETdA==
Received: from o365relay-in.synopsys.com (us03-o365relay7.synopsys.com [10.4.161.143])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
        by mailhost.synopsys.com (Postfix) with ESMTPS id 244C6A005C;
        Wed, 15 Mar 2023 21:15:48 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2170.outbound.protection.outlook.com [104.47.59.170])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id 04208A0012;
        Wed, 15 Mar 2023 21:15:46 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=thinhn@synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.b="o20MPR7K";
        dkim-atps=neutral
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Yq/+IIfGZI/4YUiY3MPbCUmEUa0QWp9tkVBIPCSO+TXJIoLm0jTR8c0AK5N6K+yKddIuzezlcgBcSWMKBn00ecopGWCax4jEAFhRE+bQAKYciodnqV3Nd81/ugYo+R/2uFTM/tqbV5D2NU3f/hZuwGoSmsu7EED84iBeR4T3TMb9pJnOqRPLafD6TThBHurjXtrY+3mraCkXucp/hcxVPcKsy40/LpNCExBZaFfnq82wIIihhkgs1N7G7axZlwQCdFcs9yO/U/xlH+7R6EnT5hAv2MD51hvT4pCuFWHUoU+bechGeIa8lE0bwZXnDOaRes6IKFKr7JJpkzfxgnurQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9yzWLphrBJDofxAcqqUSerWWtrD9JeFA1lAeEYY/owg=;
 b=nhCkcPBKPVXQVdORgykK4a3AF0+o3xEsQsAmuKuflYpRKI1Q/LvpmXsDf+5PxlrtFG6/nV9TusvfxFs2pNOQaqoBiJIzOjqwe61jt2VgaoBiKrUpFAGjopytOlo0FXoU0+hZj0Wrl6UFlNDC7+HEz9Nu1H7DP6qi25VXwNeGmvpVvb579SObBtqF5NmszL0EQJlnkKq4TM+QlKvshVz7cXSWXdIg5f9MOP3ITBtVZeie5p+6BF5MNBM94SzTEn29vudrPOhw90QdTerJeojk5wpvRvQ03noo4kYIb1jVIIQMf4NVEjZC4v7jh0NQDYh72uREvqPOzSeB/xz6gcAusg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9yzWLphrBJDofxAcqqUSerWWtrD9JeFA1lAeEYY/owg=;
 b=o20MPR7KOg0cfMye+HKc+b2tYLod14ncIsOSgZDp+SPcFFou96E4OrsuJtAGJc8MUSYotNbEePiDNXOjdqex2e6K1dHSICOFCgtDs6o/fTj1lUMXb3ZR61CSo4L2FULH0WovZTr52mpXNJndfBwM6eAU//UFR/hggi4WmlsAfnQ=
Received: from BYAPR12MB4791.namprd12.prod.outlook.com (2603:10b6:a03:10a::12)
 by CH3PR12MB8911.namprd12.prod.outlook.com (2603:10b6:610:169::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.26; Wed, 15 Mar
 2023 21:15:44 +0000
Received: from BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::3161:c44d:8bb3:423f]) by BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::3161:c44d:8bb3:423f%3]) with mapi id 15.20.6178.026; Wed, 15 Mar 2023
 21:15:43 +0000
X-SNPS-Relay: synopsys.com
From:   Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To:     Elson Roy Serrao <quic_eserrao@quicinc.com>
CC:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "balbi@kernel.org" <balbi@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "quic_wcheng@quicinc.com" <quic_wcheng@quicinc.com>,
        "quic_jackp@quicinc.com" <quic_jackp@quicinc.com>
Subject: Re: [PATCH v10 5/5] usb: gadget: f_ecm: Add suspend/resume and remote
 wakeup support
Thread-Topic: [PATCH v10 5/5] usb: gadget: f_ecm: Add suspend/resume and
 remote wakeup support
Thread-Index: AQHZV3RzS33N7pq22UWSeyeBDY77Mq78Pw+AgAAYoQA=
Date:   Wed, 15 Mar 2023 21:15:43 +0000
Message-ID: <20230315211542.z6oc2zfgpnrixgi5@synopsys.com>
References: <1678908551-27666-1-git-send-email-quic_eserrao@quicinc.com>
 <1678908551-27666-6-git-send-email-quic_eserrao@quicinc.com>
 <20230315194733.yjp5ddymehxm6abl@synopsys.com>
In-Reply-To: <20230315194733.yjp5ddymehxm6abl@synopsys.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR12MB4791:EE_|CH3PR12MB8911:EE_
x-ms-office365-filtering-correlation-id: 2439ef08-c4a1-4108-fc6c-08db259a6fdf
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: n+xPc1dAJantzXJT9Z16hZ6usl/ZhTFpnuThmcUvE1pVLwixB+466Rs+FKOUBpNrVyZ/JeZ0DDAbI+TizZDf1zZoxusmwR0Df97EVPe3c+l9r+CQty88jlxk0sCAu7ujFaP6OgBx3QlF+cCLCJ3Oc2k2dzhc+V3yRyNvngXmU3Dtkd6bQLWcVWY+2a+7xKCeqHJXtjRY1BiSkLYpEkg1JieHyuMVxkKhkn51YvwQ1cweXotbeGT3yXsOW+rLuUSxa2Pe6QT/EipS70xNycNfAGZTkJcLn0AlhVDdvG7skXnHd/sPwVPzob6n/EYrkzr5axqSq+BtxEgh5YzzN04nkoMN1+TbAoy4xDqC5F4RgAb9FyYFBVv6/2vlspaoDi3WgNb+N/KXaiBEKuZjS495jwfSK8cd2aoiVQms5yNyvyPKG9xKL8YMCnN74yBEdWA4IoHHvo/RyiKdamoIEEmvx42lbWL0BtkTVWdt1xAQmaVTT29VExh0Wn21piM8yQpknKzDZpEytrRikUyZeLk3gsBpQG8AWdLv7qdvLmHgC5NJLSs5G22RVlvQ2iMIUsDwZzRz4Fn2lFyjpi1Tt+7zoqhMsOz/ArXkNXtVbfJcp8QtqLVmzlXrHF5E84A8VKd/jknqSTcEP6S7X/0xT7jqDAco3qudOF87xUXoY5iYsxip0ufpDARAbHGv2lT9xBjU
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4791.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(346002)(366004)(396003)(39860400002)(376002)(136003)(451199018)(478600001)(83380400001)(8936002)(41300700001)(66556008)(66476007)(76116006)(6916009)(66946007)(66446008)(4326008)(54906003)(316002)(64756008)(2616005)(2906002)(38070700005)(6506007)(26005)(1076003)(6512007)(86362001)(186003)(122000001)(15650500001)(5660300002)(36756003)(8676002)(6486002)(38100700002)(71200400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WGZBaWgxYnN0T1YxNXZjSVdaMmI4L1NnUjIwaSt3YzZ6VEo3ZEQySEw0Z1pR?=
 =?utf-8?B?djgzbnRMMGl0K1RPMDV5anlRSEFFcUFQQUJsVzZQM1E4QTIrV1dJNlNjb2RW?=
 =?utf-8?B?aDMrY3I5c0EzUUh1S3ZBVGRqOGQvaVYyVVNTWmFDY1hScXNyN0ZkTzFPbWlu?=
 =?utf-8?B?eEVkdFNMY0VmclJxTGhpbmNHVEhtamliVTdIRU13WncxTnRMNE5kSDgwdTJj?=
 =?utf-8?B?dTFKek54TXJTNUg2cjVZTFBKU01JbDFVV1NOMm9aSkMyRy80alI0UWhzK2xy?=
 =?utf-8?B?NnV3UGViZ2ZXeHVDOVlqS3prS2VYaDZuTDNMOW1PVnFJcEtXeE5EQUptOWlG?=
 =?utf-8?B?OHVxZEVkRlBmc2F1aEdvZEg1UmtSZlBZUUE1RHNrcEx0VHpPM2Y3L2VFck9l?=
 =?utf-8?B?ZnMvTWJQdTE1L1B1aXlvQ1dVMTJoYUp4ZTJDNk9WQWg4RlRqaGhwcjVONFZY?=
 =?utf-8?B?Q3dzd0FXc0FtWDdDRDFvK0JYSVNSaG5vYlNGZnJrNmVxYzhjQ0N2RTV4S1lC?=
 =?utf-8?B?bHZKSDh3Wm0yTTVqS2k4bVVmd3V6eDJaeEFQOW5KeHZCZXpRMVhYaEJFOUFL?=
 =?utf-8?B?TU9VK0Vla2Qxek04QXI1U2E3ajRSUDh5QVNsY3Z6dGQ2MWhGT0J6Yk9Udko3?=
 =?utf-8?B?Yk5NS01PcGFBalVQV2ZkVVVITlNQWTc0SC8wQzhQYTNqUDFrMStiVWVzZDh6?=
 =?utf-8?B?YXp0L3JnRCs2MUlSQ25ISWNCY095ditXTVpFbGFNRlZZODZFRWE0QlE2Rk0v?=
 =?utf-8?B?ZWVJenkrYytEL2wySmE4a1Rtbjd0eGhxV0w0R0p0ZmxXQTRIQ0VQSGgrY1NB?=
 =?utf-8?B?WDdtdzZzRVVsNUpDR0ljZ2FXNlI4NmpjbXFqRHBhVW05QmRHSmxVM1dTWmRk?=
 =?utf-8?B?bjJHUUNXQW05UzlJb21Pejc0dzlVN2FVM0ZmcUFLYndsamhoSW0zOTNpSllY?=
 =?utf-8?B?aDdyNWJZajU4Q0ZKdXNqaFJYcXVMc3c0dEdDbnVENGVTME5tYjlobmNjTi82?=
 =?utf-8?B?akEzaEhIY0R2K0dXemZac1dLQkp6bENVZ1hOdlI1dXpFaWc2S2tjdXQ3dTI5?=
 =?utf-8?B?Nm90TUkrN0VpS1dEcHVmL2pnWXlVekZYcDk2SXBSRjhBLzJKdFoxU3UzQ2xI?=
 =?utf-8?B?aEdTRXNVMkNvdk1WSzlRWTZXZ1VucGlNYnJQYk5IV2NTbHN1dDc3TS9oT2ti?=
 =?utf-8?B?c0FzVnQyMzBLNlBWajNQVm9naHNyYUVLbndJZHg5eTJjenRSeXIwaTNOQXRC?=
 =?utf-8?B?Qyt1UmRQV0VUNnA2YUQreVFENGs3dmdlRlcwNTI2ekhiWnBwZEFuZHNGTUNx?=
 =?utf-8?B?RUNON1dBRExKb2J6dGhzbzEvejR1bVlwbVNNUDhNTGh3d1BGVEFBRTY0amFh?=
 =?utf-8?B?djhvRE43Tms5VjVWV29wd1lPcW1HV3dQNkUvL1pDN2w1SmVKMWc5T1g1UG1h?=
 =?utf-8?B?dlJZaE11TEVSYVZRellaNlVLbjlLZDZPZSsrdW84WWhTRTRpQkxzcEYwOXNH?=
 =?utf-8?B?OElHMkcyZWdkRCszZVR4K1dGRS84WTkyK2l0KzNSOHlQWmtYQ0x0T3FZS3E4?=
 =?utf-8?B?VE10Vzdic3k1c3BYRkY2MkxoWWgzOUQzenJ3ZEhad3hUYTB6cmNRSnBPMURh?=
 =?utf-8?B?MzVDamFQcTZBa3BBbFhpQk0vRStwdWN6Vnl6ODlZaWxsNisyaTQvRUtUU0NL?=
 =?utf-8?B?dUlJL29MU3lRV2RFMW5hRDcvNUVkRWQvdkdtTWhZY0hOUyt2SzE2Q3Fpcm41?=
 =?utf-8?B?RUJFQXk1SjY0K3dUenM0VDdQTlFKQTQ5M2ZGTis4cGNKc2RaZkxHdWxpWEhI?=
 =?utf-8?B?c25zTlRVSXZGcys2a1N6K1hDclpPa2ZIc1VBTWxuczJobXlFblpiR1BLN1Nu?=
 =?utf-8?B?dUVVSUN0SDMwODFWRUNncnBWc094RllZMm96YVNFcDdZdUpBdEpRdmJrL2xN?=
 =?utf-8?B?cEM3SUY4c0NRSktUbEVPc1RnclBUR3NUdjEzdzZCKzFCNVFaTjJjQURSY21F?=
 =?utf-8?B?V0RoVnVWS0tFTG1DY0swSUFJNzdTbnhSVmZQUHdjOU9IS1EwdVROc0VwVm44?=
 =?utf-8?B?M0Jsa1NROTh1WXdxMmRRUEtKQ3JRM281OFdKV01SbDY5eTNhaHREaXE0WFpL?=
 =?utf-8?B?VCt5dGZXNjdxaVdvRUZQR0lwZmN5M1B3OWlyNUZPdUpGRUYvTGd4eDlMalNK?=
 =?utf-8?B?alE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <35D3810AB8F39845B694D267545D632B@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: vH7r6G2Gy7dN8ZFOKU66IwOh7SmHQfb2xCyq3BgDLVVUoY83KCD2whLetyfm/giqH8A5uJUweLWemMgDWoWHDPs5Lc7UovrF+SGiNIDbpc5Q2FVwufVm20WZ36XisXPALIQcQxxOzhAuwmn5dxFq4/Ngv9FGgm/0h2r30OzhOyt0pxvAdFuQXjeOiDI1RCyLlvpGxp0FhmnMpG7pOPJi9gveWrLTywsXQY0gwyStyhrDTAQ4zrB+CLJCfGJuBwWeh5BFu/p9qZTn121MWJi2RxAWKFPhDhSqdVyrCkSumUFH+tSLVhHc9ILRLJCdiGdWLaW301ONNZOvogkDo4p9u0Qk/EpKu5jjEpyCf2xwFC6kBIoQkg3EnuatXcQdl6ghHn69hfC2LkK/SBo8/1Y7evyVGV0vE7tQhbhhirWFn0XoE4kRfkZgWD9Dt2uK2JXC3gvFZ330OU/PaLm/zI4PZBEQo9EHvYm5TVrgAir4wDDIip5JW+BY0wP3pu30l4ho7XYblXzt2B2pkBN5lGC/d9D0M+yquO6jLvjnTHP4uxNBQCy4kNvqUsBxXKQK77aci99yWEJ7VbMn0F2W4ruoedhtL+nY2TArPtzkyt83aS4B0nVpvk5SnOzED2j/W3LTzrizbr4vsNFkwm1sS23+BsekMbnXQNh/SG5NwXsZLzq1WU1RGHjXb6OM2NtjYYnbDjtT4Rahucwl52beuG6xiJ7GaGaS6V/dYX9OoQLuPwKI4aMw4K1W6/TXDn6ob3s5QJQSgDrGDS9BlViN4n35an6Zr94HEYzsh5GdJtTJsyuPT1OZBuhg0Z7RWs/OE1NCAWJqgnLF+E5MNXV6HLiniwvYOpWz2Mo9xyWk69jJ+AKzF5dT30N8ZUyaYhIde07lo8UeWHh597G4qkJ44gi4O6HoVY5YRCNYOHD2HR5zdrM=
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4791.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2439ef08-c4a1-4108-fc6c-08db259a6fdf
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Mar 2023 21:15:43.5042
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DcfwKsHZjevRA9R7C20VObMPZsBGd3wsXWh81hHxxNng/vuB1canpJp6FIVCbELQVQ26gl/dfetkCqtaVe7i5w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8911
X-Proofpoint-GUID: RPwizyDLFSfDYQahR4sGlENLnLuvPI7_
X-Proofpoint-ORIG-GUID: RPwizyDLFSfDYQahR4sGlENLnLuvPI7_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-15_12,2023-03-15_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 lowpriorityscore=0 adultscore=0 bulkscore=0 phishscore=0 impostorscore=0
 clxscore=1015 mlxscore=0 malwarescore=0 mlxlogscore=890 suspectscore=0
 priorityscore=1501 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2303150000 definitions=main-2303150175
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCBNYXIgMTUsIDIwMjMsIFRoaW5oIE5ndXllbiB3cm90ZToNCj4gT24gV2VkLCBNYXIg
MTUsIDIwMjMsIEVsc29uIFJveSBTZXJyYW8gd3JvdGU6DQo+ID4gV2hlbiBob3N0IHNlbmRzIGEg
c3VzcGVuZCBub3RpZmljYXRpb24gdG8gdGhlIGRldmljZSwgaGFuZGxlDQo+ID4gdGhlIHN1c3Bl
bmQgY2FsbGJhY2tzIGluIHRoZSBmdW5jdGlvbiBkcml2ZXIuIEVuaGFuY2VkIHN1cGVyDQo+ID4g
c3BlZWQgZGV2aWNlcyBjYW4gc3VwcG9ydCBmdW5jdGlvbiBzdXNwZW5kIGZlYXR1cmUgdG8gcHV0
IHRoZQ0KPiA+IGZ1bmN0aW9uIGluIHN1c3BlbmQgc3RhdGUuIEhhbmRsZSBmdW5jdGlvbiBzdXNw
ZW5kIGNhbGxiYWNrLg0KPiA+IA0KPiA+IERlcGVuZGluZyBvbiB0aGUgcmVtb3RlIHdha2V1cCBj
YXBhYmlsaXR5IHRoZSBkZXZpY2UgY2FuIGVpdGhlcg0KPiA+IHRyaWdnZXIgYSByZW1vdGUgd2Fr
ZXVwIG9yIHdhaXQgZm9yIHRoZSBob3N0IGluaXRpYXRlZCByZXN1bWUgdG8NCj4gPiBzdGFydCBk
YXRhIHRyYW5zZmVyIGFnYWluLg0KPiA+IA0KPiA+IFNpZ25lZC1vZmYtYnk6IEVsc29uIFJveSBT
ZXJyYW8gPHF1aWNfZXNlcnJhb0BxdWljaW5jLmNvbT4NCj4gPiAtLS0NCj4gPiAgZHJpdmVycy91
c2IvZ2FkZ2V0L2Z1bmN0aW9uL2ZfZWNtLmMgICB8IDc3ICsrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrDQo+ID4gIGRyaXZlcnMvdXNiL2dhZGdldC9mdW5jdGlvbi91X2V0aGVyLmMg
fCA2MyArKysrKysrKysrKysrKysrKysrKysrKysrKysrDQo+ID4gIGRyaXZlcnMvdXNiL2dhZGdl
dC9mdW5jdGlvbi91X2V0aGVyLmggfCAgNCArKw0KPiA+ICAzIGZpbGVzIGNoYW5nZWQsIDE0NCBp
bnNlcnRpb25zKCspDQo+ID4gDQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdXNiL2dhZGdldC9m
dW5jdGlvbi9mX2VjbS5jIGIvZHJpdmVycy91c2IvZ2FkZ2V0L2Z1bmN0aW9uL2ZfZWNtLmMNCj4g
PiBpbmRleCBhN2FiMzBlLi5mZWEwN2FiIDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvdXNiL2dh
ZGdldC9mdW5jdGlvbi9mX2VjbS5jDQo+ID4gKysrIGIvZHJpdmVycy91c2IvZ2FkZ2V0L2Z1bmN0
aW9uL2ZfZWNtLmMNCj4gPiBAQCAtNjMzLDYgKzYzMyw4IEBAIHN0YXRpYyB2b2lkIGVjbV9kaXNh
YmxlKHN0cnVjdCB1c2JfZnVuY3Rpb24gKmYpDQo+ID4gIA0KPiA+ICAJdXNiX2VwX2Rpc2FibGUo
ZWNtLT5ub3RpZnkpOw0KPiA+ICAJZWNtLT5ub3RpZnktPmRlc2MgPSBOVUxMOw0KPiA+ICsJZi0+
ZnVuY19zdXNwZW5kZWQgPSBmYWxzZTsNCj4gPiArCWYtPmZ1bmNfd2FrZXVwX2FybWVkID0gZmFs
c2U7DQo+ID4gIH0NCj4gPiAgDQo+ID4gIC8qLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLSovDQo+ID4gQEAgLTg4
NSw2ICs4ODcsNzcgQEAgc3RhdGljIHN0cnVjdCB1c2JfZnVuY3Rpb25faW5zdGFuY2UgKmVjbV9h
bGxvY19pbnN0KHZvaWQpDQo+ID4gIAlyZXR1cm4gJm9wdHMtPmZ1bmNfaW5zdDsNCj4gPiAgfQ0K
PiA+ICANCj4gPiArc3RhdGljIHZvaWQgZWNtX3N1c3BlbmQoc3RydWN0IHVzYl9mdW5jdGlvbiAq
ZikNCj4gPiArew0KPiA+ICsJc3RydWN0IGZfZWNtICplY20gPSBmdW5jX3RvX2VjbShmKTsNCj4g
PiArCXN0cnVjdCB1c2JfY29tcG9zaXRlX2RldiAqY2RldiA9IGVjbS0+cG9ydC5mdW5jLmNvbmZp
Zy0+Y2RldjsNCj4gPiArDQo+ID4gKwlpZiAoZi0+ZnVuY19zdXNwZW5kZWQpIHsNCj4gPiArCQlE
QkcoY2RldiwgIkZ1bmN0aW9uIGFscmVhZHkgc3VzcGVuZGVkXG4iKTsNCj4gPiArCQlyZXR1cm47
DQo+ID4gKwl9DQo+ID4gKw0KPiA+ICsJREJHKGNkZXYsICJFQ00gU3VzcGVuZFxuIik7DQo+ID4g
Kw0KPiA+ICsJZ2V0aGVyX3N1c3BlbmQoJmVjbS0+cG9ydCk7DQo+ID4gK30NCj4gPiArDQo+ID4g
K3N0YXRpYyB2b2lkIGVjbV9yZXN1bWUoc3RydWN0IHVzYl9mdW5jdGlvbiAqZikNCj4gPiArew0K
PiA+ICsJc3RydWN0IGZfZWNtICplY20gPSBmdW5jX3RvX2VjbShmKTsNCj4gPiArCXN0cnVjdCB1
c2JfY29tcG9zaXRlX2RldiAqY2RldiA9IGVjbS0+cG9ydC5mdW5jLmNvbmZpZy0+Y2RldjsNCj4g
PiArDQo+ID4gKwkvKg0KPiA+ICsJICogSWYgdGhlIGZ1bmN0aW9uIGlzIGluIFVTQjMgRnVuY3Rp
b24gU3VzcGVuZCBzdGF0ZSwgcmVzdW1lIGlzDQo+ID4gKwkgKiBjYW5jZWxlZC4gSW4gdGhpcyBj
YXNlIHJlc3VtZSBpcyBkb25lIGJ5IGEgRnVuY3Rpb24gUmVzdW1lIHJlcXVlc3QuDQo+ID4gKwkg
Ki8NCj4gPiArCWlmIChmLT5mdW5jX3N1c3BlbmRlZCkNCj4gPiArCQlyZXR1cm47DQo+ID4gKw0K
PiA+ICsJREJHKGNkZXYsICJFQ00gUmVzdW1lXG4iKTsNCj4gPiArDQo+ID4gKwlnZXRoZXJfcmVz
dW1lKCZlY20tPnBvcnQpOw0KPiA+ICt9DQo+ID4gKw0KPiA+ICtzdGF0aWMgaW50IGVjbV9nZXRf
c3RhdHVzKHN0cnVjdCB1c2JfZnVuY3Rpb24gKmYpDQo+ID4gK3sNCj4gPiArCXN0cnVjdCB1c2Jf
Y29uZmlndXJhdGlvbiAqYyA9IGYtPmNvbmZpZzsNCj4gPiArDQo+ID4gKwkvKiBEMCBhbmQgRDEg
Yml0IHNldCB0byAwIGlmIGRldmljZSBpcyBub3Qgd2FrZXVwIGNhcGFibGUgKi8NCj4gPiArCWlm
ICghKFVTQl9DT05GSUdfQVRUX1dBS0VVUCAmIGMtPmJtQXR0cmlidXRlcykpDQo+ID4gKwkJcmV0
dXJuIDA7DQo+ID4gKw0KPiA+ICsJcmV0dXJuIChmLT5mdW5jX3dha2V1cF9hcm1lZCA/IFVTQl9J
TlRSRl9TVEFUX0ZVTkNfUlcgOiAwKSB8DQo+ID4gKwkJVVNCX0lOVFJGX1NUQVRfRlVOQ19SV19D
QVA7DQo+ID4gK30NCj4gPiArDQo+ID4gK3N0YXRpYyBpbnQgZWNtX2Z1bmNfc3VzcGVuZChzdHJ1
Y3QgdXNiX2Z1bmN0aW9uICpmLCB1OCBvcHRpb25zKQ0KPiA+ICt7DQo+ID4gKwlzdHJ1Y3QgdXNi
X2NvbmZpZ3VyYXRpb24gKmMgPSBmLT5jb25maWc7DQo+ID4gKw0KPiA+ICsJREJHKGMtPmNkZXYs
ICJmdW5jIHN1c3AgJXUgY21kXG4iLCBvcHRpb25zKTsNCj4gPiArDQo+ID4gKwkvKiBSZXNwb25k
IHdpdGggbmVnYXRpdmUgZXJybm8gaWYgcmVxdWVzdCBpcyBub3Qgc3VwcG9ydGVkICovDQo+ID4g
KwlpZiAoIShVU0JfQ09ORklHX0FUVF9XQUtFVVAgJiBjLT5ibUF0dHJpYnV0ZXMpKQ0KPiA+ICsJ
CXJldHVybiAtRUlOVkFMOw0KPiANCj4gV2Ugb25seSBuZWVkIHRvIHJldHVybiBlYXJseSBpZiB0
aGUgaG9zdCB0cmllcyB0byBlbmFibGUgcmVtb3RlIHdha2UNCj4gd2hpbGUgdGhlIGRldmljZSBp
c24ndCBjYXBhYmxlIG9mIGl0Og0KPiANCj4gCXdha2V1cF9zZWwgPSAhIShvcHRpb25zICYgKFVT
Ql9JTlRSRl9GVU5DX1NVU1BFTkRfUlcgPj4gOCkpOw0KPiAJaWYgKHdha2V1cF9zZWwgJiYgIShV
U0JfQ09ORklHX0FUVF9XQUtFVVAgJiBjLT5ibUF0dHJpYnV0ZXMpKQ0KPiAJCXJldHVybiAtRUlO
VkFMOw0KPiANCj4gCWYtPmZ1bmNfd2FrZXVwX2FybWVkID0gd2FrZXVwX3NlbDsNCj4gDQoNCkFs
c28sIEkgbm90aWNlIHRoYXQgd2UgY2FuJ3QgZGlmZmVyZW50aWF0ZSBiZXR3ZWVuIENsZWFyRmVh
dHVyZSgpIGFuZA0KU2V0RmVhdHVyZSgpIGluIGYtPmZ1bmNfc3VzcGVuZCgpLiBQZXJoYXBzIHdl
IHNob3VsZCBoYW5kbGUgYXJtaW5nIHRoZQ0KcmVtb3RlIHdha2V1cCBpbiB0aGUgY29tcG9zaXRl
IGxheWVyIHNvIHdlIGNhbiBzZXQvY2xlYXIgdGhlIHJlbW90ZQ0Kd2FrZS4gSXQncyBjb21tb24g
YWNyb3NzIG11bHRpcGxlIGRldmljZXMuIEl0J3MgcHJvYmFibHkgYmV0dGVyIHRvIGJlDQp0aGVy
ZS4NCg0KVGhhbmtzLA0KVGhpbmg=
