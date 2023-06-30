Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03AC07444CD
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jul 2023 00:24:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231657AbjF3WYN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 18:24:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231764AbjF3WYJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 18:24:09 -0400
Received: from mx0b-00230701.pphosted.com (mx0b-00230701.pphosted.com [148.163.158.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0159D3C22;
        Fri, 30 Jun 2023 15:24:07 -0700 (PDT)
Received: from pps.filterd (m0098572.ppops.net [127.0.0.1])
        by mx0b-00230701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35UIPrcX005674;
        Fri, 30 Jun 2023 15:24:02 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=pfptdkimsnps;
 bh=k8Jrgb3zWuQJletqjypmanc+tg0J+riMWRXStp1pCUc=;
 b=nl6Ts3uaQD2yVWP+DgXuP+vE3XQJLjA70S8T5AgQmBwG1/GYIlglpXv6hm1MiduFUgQR
 uSOHCctBMFv6IoTtU3xc0vpkW4PLRM636oAoPsfj2Lbs8dSZP9STIxhiyrPnML+oxcNA
 qSZOEsRYq0briYrIvzkKDZzfJfPXbt8SY8KtfrJVkVsZlMWa5oE+KxPnKwglnqyrMBsq
 rhwyLckis+IXBOtAnwVZJxZhadKfEFzqRp82I4xbX3ROx/1kfeBmehrTEpH1qOdRbQJS
 jH/l/SI3ReJ58kkQaFJ+6BNwxc957h3RQysermrVuytk/VEbb/wip1v412c6W/0xBw+/ bQ== 
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.73.133])
        by mx0b-00230701.pphosted.com (PPS) with ESMTPS id 3rdy4etyrq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 30 Jun 2023 15:24:01 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1688163840; bh=k8Jrgb3zWuQJletqjypmanc+tg0J+riMWRXStp1pCUc=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=jCEp6O3X5vfXeDQWgGyf6XaRuZp9v28UxsJvg07G9FqOiylFvLyVjp9lL66nsmC0Y
         sYhY2hW35ny9iikAg6fA8Uthi5x7ceHoMRZxKZYOQlJTw/5uZRSFSPAnI9ferQ+S5O
         8Gk+O5n3fTfHswoLKpY9DSz2F2f5cFmGmJdHe6Ke91f62y5cdrbixYrGcHjN9vggcw
         HrfaF1xWprpend0c74dZy5GGnks8mk15RF7gLc2BRBE2HZZ4/ggGsQ/Vyu+7bv2YO5
         BSfmV7vqueYZ5N4LodzUkDbbDD7I8OHY83Pq+53e6iz1dWf66Tg2yNFG87O39AjAeT
         253PbCns6AQvw==
Received: from mailhost.synopsys.com (sv1-mailhost2.synopsys.com [10.205.2.132])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits)
         client-signature RSA-PSS (2048 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 66A92401DA;
        Fri, 30 Jun 2023 22:24:00 +0000 (UTC)
Received: from o365relay-in.synopsys.com (sv2-o365relay1.synopsys.com [10.202.1.137])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
        by mailhost.synopsys.com (Postfix) with ESMTPS id EC837A00D1;
        Fri, 30 Jun 2023 22:23:59 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=tmiOr1VT;
        dkim-atps=neutral
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2168.outbound.protection.outlook.com [104.47.73.168])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id 6A15C40236;
        Fri, 30 Jun 2023 22:23:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MivFILeUYqmA/faN/pFo8amikxTY+v/6jWmwNvsw9ZqT6aecxGXzREjKMJ01f8/axVQb5hNShfeFjIFqrl4o01KNr3TWB1QYMrbw6/sdv0pQNuX7MgC+JLPjUeDthSmxzneU1m2kw1eevEwbyIlLH1sAika6CcnEL5Ay4G9DgZB6pBzZRD7jaJ1+crCVPzsF4F2Cm3GQG/GvdjZA8xXFRd+S5EJe/hEe6qyGEdPYXPlelREvJY9VXtMW9VEVwugh3g7a6dwOSzy5H0wQuf9Kd2dInqdn2J1Foyk9Q3gPyVgBexRVS/u+70MxZJ9LBOsGwWygirfSCRQVBfe7Qpvb/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k8Jrgb3zWuQJletqjypmanc+tg0J+riMWRXStp1pCUc=;
 b=Tv+i83h4fUtPl2hCy9KTj2OvKx1ZvH3DuFQQQWMu2YsaKN8nt2Rh0u01w0RQgduzZXcubADG1Sg7bO6I9ime2wEuBIDkSf/6IuWw1rbasqZq92uFj6/iNN347FlSohSadbdf6t2XARNIis84QzmoMh0UFhMkS7IMQiSoErICia1ajWbz+k8BZySRdFOVL+75g7K2yngNZvRy7S86MJgGIEyvR4pLjWcWm1zIdbHAn2jJH/5z0xnLDsuYchJdxYZW5saiWYNuvKDnAHYSfseL0/DRwiKpFNr/W3ZpQhYfWwtx2L7YIGSFixfYqa4Fh1bt2hshnsrWX9hS16Xop4gTpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k8Jrgb3zWuQJletqjypmanc+tg0J+riMWRXStp1pCUc=;
 b=tmiOr1VTwl24MxQgHPXJ/1jYr3I8TDJKK6RnSkp2NCtxJgkebssmdqYMCmYJXXO4LjOiinC64kVinnGWbGIUSDtS2PLaU6b819jktaYp9iM6xE2W5BvgAIgOpWnZohy/qX/Wjh5/BnDDi3Yg+3tf8CIoro0lR8FhVlmOMhmY6Oc=
Received: from BYAPR12MB4791.namprd12.prod.outlook.com (2603:10b6:a03:10a::12)
 by SJ2PR12MB8010.namprd12.prod.outlook.com (2603:10b6:a03:4c7::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.19; Fri, 30 Jun
 2023 22:23:56 +0000
Received: from BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::b1a4:d803:b2ff:cc6b]) by BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::b1a4:d803:b2ff:cc6b%3]) with mapi id 15.20.6544.019; Fri, 30 Jun 2023
 22:23:56 +0000
X-SNPS-Relay: synopsys.com
From:   Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To:     Jisheng Zhang <jszhang@kernel.org>
CC:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] usb: dwc3: don't reset device side if dwc3 was configured
 as host-only
Thread-Topic: [PATCH] usb: dwc3: don't reset device side if dwc3 was
 configured as host-only
Thread-Index: AQHZqRTf4q+DvcsDPkC4WtyRTVBkQa+j8PCA
Date:   Fri, 30 Jun 2023 22:23:56 +0000
Message-ID: <20230630222353.uxaaa3t2av2fktu7@synopsys.com>
References: <20230627162018.739-1-jszhang@kernel.org>
In-Reply-To: <20230627162018.739-1-jszhang@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR12MB4791:EE_|SJ2PR12MB8010:EE_
x-ms-office365-filtering-correlation-id: 2d269f3e-3e6d-4c74-5cb3-08db79b8b170
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: UxY+Gz2NHGGGgFOzf3ZAXKtOusZOpblvRxaUDDQmJSNNv7P/92Z0YdwoG+AwA/uVi+88X2I6hCWzXUyTFyO3y88zh6mDTow7a7nKQ6D2eZQuHgyXVkYMX8xxppsjzvA6jVnSaqUGGJd2cIrv+ddmqoXB2OUL41rLm6a+zLCn50PrSUOP016rSIShytrRMOgqr24uyqRVUHreNSpHc9TtTdEclqrefQ7NsK3THki4ChAnlBUU0M409m1wLu9tSuB/bMOP4ISePn4glpe/TN77DTu93KnPMIHRngWJn1kCwvnZTB0s0B+UIGmIy3Y0/5Dv08xljkKNI+ZoKBoGkt/OX1m/Uae8lwyPmQ4v//uj7aqV+k+50Efnd1vI/FWdZCmmkioD2QCIOop7rJnXadMrAh5R+6/rnuLYIPiNRJsLszMGDmDvqVIWNg/mg5fLTpbiHIxAfTyhmE2EL0gbeUk609lTpTceoK5mOZFSYJMSytGU3ar4x4T3nzTVoEUVNYU7XFCzzUkj0KS7uDqcHhrsMyyW0S8wBOR2ZpIq85GPDeJffziIJzN9Wes4nuzIEiSV/6RaznU/fJXiMRdtf8hvqrOCC7/Pi3UAIbgrLQCSsFOfirhydVG6J7Hu3eLAXIan
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4791.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(346002)(39860400002)(396003)(136003)(376002)(451199021)(83380400001)(38070700005)(2616005)(2906002)(122000001)(38100700002)(36756003)(8936002)(8676002)(5660300002)(86362001)(71200400001)(54906003)(6512007)(41300700001)(76116006)(66556008)(66476007)(66446008)(64756008)(6916009)(4326008)(316002)(66946007)(6486002)(478600001)(186003)(1076003)(6506007)(26005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WFBCTWJIckdrV254Z1NRRU1hZE5qeXJiNGo5VnhYYkNFWjNrQ2FlV3J1Qm9Q?=
 =?utf-8?B?VUVza1J4anFPbWJwUEhYSWROU0VRZk1sQWxpMGovazc3RGdyQmhLQVFQZjlu?=
 =?utf-8?B?VTBvZUsyOC9ZM1BYZjdTMHJ0ZUdMR3RWRHhFVTc2cmZCdkdML3hQQTd2ckxx?=
 =?utf-8?B?TFE1NHliUWthQXZaS28xZkpRd3JNcXhWdTgySUlaQmlmWXNiY0NTYWpuc3RB?=
 =?utf-8?B?V2doOFRWcGZ3N2ZDSWRkeFRYZ1JMMG9TeGFTRi9qcHRwdUJkRkxGMDlpUFc4?=
 =?utf-8?B?ZmQ2bVcvMEFFN2p4RC80ZExoQU1kUzFManJJRzF6bWdxQTZwZUlHNGFueFFO?=
 =?utf-8?B?ZmFsNUNGUzg1alVKaTRjd2QwSEVSdWlRUVdBM0lSYlBZZ0s1NWQ0VVV5T2w1?=
 =?utf-8?B?ZmttWXUxa0RYMFEzeDNGemRTRHYyNzZYSEJRRzh1MnZvUy9aYWpPUW5ORHZV?=
 =?utf-8?B?bzNPbEhtcjVSTHk4SlMwRi8zL3pFWnZEUjhZSVcrSlFsSnJzMlRwWmg5UGln?=
 =?utf-8?B?STduYjE1RHlKcU5sK1hKL1lsY05TbHRXKzNZN2Rjd1Y5a1M4Y3QraHNUb2k1?=
 =?utf-8?B?eXFDQm1lbXVqVW4xejhqK0RFMWVrS3RXdEVReWR4VU9wQW9VNkxYbzR0S1A1?=
 =?utf-8?B?alVWaXM4c2o5bnJTakxwZTk3T2NmWkRDeG54aXI0dysvRFVJVTZnaUJ4bmpq?=
 =?utf-8?B?eTZZcVFocm1kTG1KejRJVVFIMHEzUFRjYnNJTHdJM0hXNTZNSlRKTUtzSEp6?=
 =?utf-8?B?SmJaKytXMG1UTTFiN0Judi9sdkdEV0dwNjhXSElRcHV1U1orREs3RHNsYmNj?=
 =?utf-8?B?clorMVNwTjVNbVNQRUZzaWZGdmNMU2J1WkdERWI4KzZ5VWYySEhvS1A5NWYy?=
 =?utf-8?B?MGZtbDVrWXh3bVo0dVdsOHFDdUk3Z2oxZG0yanZTYXkrOGNpSEpsVmxUMjVu?=
 =?utf-8?B?R2lRZkZSdGRsbzlLbVkzaXRVUnFNTzFJVGNFTEluV2w1RDNvcGFRZ2JhZjB5?=
 =?utf-8?B?RndiRTFiUG1HdW5tUGMrOXhqQkYrODhjd2U2c2RacVlMdHJBUmhMU2FxelVl?=
 =?utf-8?B?alEzT21jdlV4MTVCSU9ZVmhIYmRETm5nbGxIY1BTRlUrZTJCenNxWERpWTc3?=
 =?utf-8?B?ajFlWlJzTFJnWEtIUTNHbkdTMjlwaUE1WTUwZUxEc2ZPUXgyQ2s0L0xBaUNu?=
 =?utf-8?B?Skk0MWxCZVgySVJBUW1DTlB0Zm1wd1BwbmRrelFseUFJaVhiTnYxSVd2djlU?=
 =?utf-8?B?Qmp2eVhrL2MzRUFJWEFLQmdzK2dZN1NadWdlbG5zSnRCMmZWS29PRzczYm5Q?=
 =?utf-8?B?S2lxSE5vTEkwRDlYR2wrMCs4M2NRalVmd1VWaVVQOFNtQm54cFBZbDNnWUJB?=
 =?utf-8?B?dG1PcGhITVU3aExFTGNXZ1JPRUtydTlUNno2Q29zTjI1dFphZ2d6a09FRHRT?=
 =?utf-8?B?dlVITzEvSmZYcXVFZEIzK3BUU2hqemRQNmVWems5emZPTC9BenB4eituMXBq?=
 =?utf-8?B?d01vaDlSdDR4ZzliazVPNDRQTnR0bVFua1BRaVMvVFE3WmtOY2NUeTFURUhu?=
 =?utf-8?B?WEpnMUhOT2NDZitTSG5TUDJJcjJnU3JuZUZMTVkzeDZURE5NeUtHV3RVVS9o?=
 =?utf-8?B?Q3RDbHhWS296RldvM3g1cWczSGR0MWxubC9hejdoSWMvOU01TnppaG5HMG04?=
 =?utf-8?B?aTU5d215RW9jTWVIWVhoSUdEMng3WjhSYm1ZT3hTMlNWdlFrcDRySCt6VlRS?=
 =?utf-8?B?enRlMk1ubGl0anJpa29qRC9IUHIzRnl5eG5hcWo3T0FmY3U0dUl3VkxydGp1?=
 =?utf-8?B?ZmFmN0NzS2hNb0tyclpqcjVuMkVtdmNPVE5hRjFXWWY3ZHI2VUc5bEhsVk1h?=
 =?utf-8?B?T2w2VFFWcTJYM1prMGVtSjZGaURMeGYzZ2VNQ2FzeUxoK0NIVE1WN2F0WSt0?=
 =?utf-8?B?bllNREk3ek1EL3NyOW1Vc2JQOWdyZ2VHMWpvRWF2RzcrYkJPa2ZLeU5xci9h?=
 =?utf-8?B?ZEY1RDNlM2FZR3g1enFpbThiRkw4em9XNXp6eXNkVUYxKzBXZXVvU3VSUGJ3?=
 =?utf-8?B?MlgxcEd6bnhuTEFJUXVJSVQvSEw5WEpnWEhxSkNqWlFOMm53emtCYlJ4akhj?=
 =?utf-8?Q?wSiw5ZvAyw5BqSCaKbR0WCP05?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7B298640D18162488AD2553A0B46D2BB@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: thYBGBMRZiwk7V4kiG0sOe9+IoA6mw6ESh3yeR5ZZaXWotbgx/u/NLAv1Sw98y4rnWjKj9DUIySwn0hHsTXuxM9T1yfG3mVwLfVC+sybkseiHrWJySJdzWhfSb9xvUOqo7n2Dw4si5MikZSmhIHjbxu36f7UHc7dchxnC544j+TibMx1BmXkHNNzGI6Tia39B5v9ltZokt2tAwRrTUYYEF65NwTaB2Uhpmod+lXPU8VQKqM2wtaAZ4mH8tE6+JN4+6FkTZlY1c7Vpmy4vdwr5UPmSr+13S4mnJ0zpWGW8dwwOhoClEqsrT3Y7MPv72lppKUHkxLCoU3bh88AKPRkEzZ1IBcOIzYdJaTD6cp6idON7KFs+s90/f53PCiRgNlE7XtQD4D1VphLeqBtOIS40dKy+YfdsA4uhPXEFnf+3s35yfPCivw8RcLkeSK3rJc8SG6LxTHXwPFwt3ehOFh1TdSsqZE1SWhDBCwe1hNXzNK9c8mBt45rimx8Tcx1r0eV1pdeLFo+MVs6e+F7t+VUIqfW5Jh+jWUePv2ECLK5vXqxlKaon24FEqraM4wI+lsXpjagSYTqz33NtV9VM2Tvr3vKUucNzR4HfcqObUvfRZW/kw89b09wDWUsnV0y4TYLts7cGvMHhHa6/MkFzsbkr6fNbv/cvTtdRmLoe8nJWNl3Y5S9fFCP0La8xWU8CMcFAytLeto7DxeYFvDkqQMDlwoLpVr+CbJVFhUUE+In91kmDouI6zC244CgT3uNd5+kqWZuZrM4fhDiBfRNKpPGikwCqJucehxXLsfpWsPtT7GZj3NO2KR48JW7zJsN+Cu67OgMZUt4MdFOwOxp7fLwqKKAbqKRsMFDnpFyFwIhyx3r1k3y+eW626iYwg0VOKNVH6tE2wl0dlza278/d8KVfg==
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4791.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d269f3e-3e6d-4c74-5cb3-08db79b8b170
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jun 2023 22:23:56.0845
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VPVzqrVbvO2ccay0ZEddxsB7exdTdJbSZLom1xozGFynmCoId3PHFIdA2dzv+PkT2IczwXopiAWF8KDa+Tn3KQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8010
X-Proofpoint-GUID: K5eRaTfgPbFX7riyOG60NeNHK26jsMZp
X-Proofpoint-ORIG-GUID: K5eRaTfgPbFX7riyOG60NeNHK26jsMZp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-30_12,2023-06-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 adultscore=0 phishscore=0 clxscore=1011 lowpriorityscore=0
 priorityscore=1501 suspectscore=0 mlxscore=0 mlxlogscore=975
 impostorscore=0 malwarescore=0 spamscore=0 bulkscore=0 classifier=spam
 adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2306300195
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCBKdW4gMjgsIDIwMjMsIEppc2hlbmcgWmhhbmcgd3JvdGU6DQo+IENvbW1pdCBjNGE1
MTUzZTg3ZmQgKCJ1c2I6IGR3YzM6IGNvcmU6IFBvd2VyLW9mZiBjb3JlL1BIWXMgb24NCj4gc3lz
dGVtX3N1c3BlbmQgaW4gaG9zdCBtb2RlIikgcmVwbGFjZXMgY2hlY2sgZm9yIEhPU1Qgb25seSBk
cl9tb2RlIHdpdGgNCj4gY3VycmVudF9kcl9yb2xlLiBCdXQgZHVyaW5nIGJvb3RpbmcsIHRoZSBj
dXJyZW50X2RyX3JvbGUgaXNuJ3QNCj4gaW5pdGlhbGl6ZWQsIHRodXMgdGhlIGRldmljZSBzaWRl
IHJlc2V0IGlzIGFsd2F5cyBpc3N1ZWQgZXZlbiBpZiBkd2MzDQo+IHdhcyBjb25maWd1cmVkIGFz
IGhvc3Qtb25seS4gV2hhdCdzIG1vcmUsIG9uIHNvbWUgcGxhdGZvcm1zIHdpdGggaG9zdA0KPiBv
bmx5IGR3YzMsIGF3YXlzIGlzc3VpbmcgZGV2aWNlIHNpZGUgcmVzZXQgYnkgYWNjZXNzaW5nIGRl
dmljZSByZWdpc3Rlcg0KPiBibG9jayBjYW4gY2F1c2Uga2VybmVsIHBhbmljLg0KPiANCg0KQWgu
Li4gZ29vZCBjYXRjaCENCg0KVGhpcyBzaG91bGQgYmUgYmFja3BvcnRlZCB0byBzdGFibGUuDQoN
ClNvIHBlcmhhcHMgeW91IG9yIEdyZWcgY2FuIGFkZCBDYzogc3RhYmxlQHZnZXIua2VybmVsLm9y
Zw0KDQo+IEZpeGVzOiBjNGE1MTUzZTg3ZmQgKCJ1c2I6IGR3YzM6IGNvcmU6IFBvd2VyLW9mZiBj
b3JlL1BIWXMgb24gc3lzdGVtX3N1c3BlbmQgaW4gaG9zdCBtb2RlIikNCj4gU2lnbmVkLW9mZi1i
eTogSmlzaGVuZyBaaGFuZyA8anN6aGFuZ0BrZXJuZWwub3JnPg0KPiAtLS0NCj4gIGRyaXZlcnMv
dXNiL2R3YzMvY29yZS5jIHwgNCArKy0tDQo+ICAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25z
KCspLCAyIGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdXNiL2R3YzMv
Y29yZS5jIGIvZHJpdmVycy91c2IvZHdjMy9jb3JlLmMNCj4gaW5kZXggN2IyY2UwMTNjYzViLi4x
NmQ3YTFkMWNiZmEgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvdXNiL2R3YzMvY29yZS5jDQo+ICsr
KyBiL2RyaXZlcnMvdXNiL2R3YzMvY29yZS5jDQo+IEBAIC0yNzcsOSArMjc3LDkgQEAgaW50IGR3
YzNfY29yZV9zb2Z0X3Jlc2V0KHN0cnVjdCBkd2MzICpkd2MpDQo+ICAJLyoNCj4gIAkgKiBXZSdy
ZSByZXNldHRpbmcgb25seSB0aGUgZGV2aWNlIHNpZGUgYmVjYXVzZSwgaWYgd2UncmUgaW4gaG9z
dCBtb2RlLA0KPiAgCSAqIFhIQ0kgZHJpdmVyIHdpbGwgcmVzZXQgdGhlIGhvc3QgYmxvY2suIElm
IGR3YzMgd2FzIGNvbmZpZ3VyZWQgZm9yDQo+IC0JICogaG9zdC1vbmx5IG1vZGUsIHRoZW4gd2Ug
Y2FuIHJldHVybiBlYXJseS4NCj4gKwkgKiBob3N0LW9ubHkgbW9kZSBvciBjdXJyZW50IHJvbGUg
aXMgaG9zdCwgdGhlbiB3ZSBjYW4gcmV0dXJuIGVhcmx5Lg0KPiAgCSAqLw0KPiAtCWlmIChkd2Mt
PmN1cnJlbnRfZHJfcm9sZSA9PSBEV0MzX0dDVExfUFJUQ0FQX0hPU1QpDQo+ICsJaWYgKGR3Yy0+
ZHJfbW9kZSA9PSBVU0JfRFJfTU9ERV9IT1NUIHx8IGR3Yy0+Y3VycmVudF9kcl9yb2xlID09IERX
QzNfR0NUTF9QUlRDQVBfSE9TVCkNCj4gIAkJcmV0dXJuIDA7DQo+ICANCj4gIAlyZWcgPSBkd2Mz
X3JlYWRsKGR3Yy0+cmVncywgRFdDM19EQ1RMKTsNCj4gLS0gDQo+IDIuNDAuMQ0KPiANCg0KQWNr
ZWQtYnk6IFRoaW5oIE5ndXllbiA8VGhpbmguTmd1eWVuQHN5bm9wc3lzLmNvbT4NCg0KVGhhbmtz
LA0KVGhpbmgNCg==
