Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 274AD6DCF22
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 03:19:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229957AbjDKBS7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Apr 2023 21:18:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229692AbjDKBSz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Apr 2023 21:18:55 -0400
Received: from mx0a-00230701.pphosted.com (mx0a-00230701.pphosted.com [148.163.156.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80EFBCA;
        Mon, 10 Apr 2023 18:18:33 -0700 (PDT)
Received: from pps.filterd (m0098571.ppops.net [127.0.0.1])
        by mx0a-00230701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33AJ5tGv014497;
        Mon, 10 Apr 2023 18:17:58 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=pfptdkimsnps;
 bh=zZCRsC/jgUUc6Aln++bBRTdqe0KTJbIMtdjeXgucSw0=;
 b=TC9Sa7ouNlTn2CM+zfeXAjfTIn6ozV8cZgUHeipjoxLbfLHGXFvop3vCjnrGYYwhS7wT
 4Wo3dCoukBm8JpYGVlUBudlfSKXlP559blxtEcPPRuK0YLPKlsmcV6FM6xU+fvT9TbsF
 SYFScv7ByIjV0c4MVM5kxw/kVyAm7bfNZ0gUkLs+qlPKAr8Pg29w5Gdx3XFtWCcACIOU
 erSrGpxpL+T5A4gBZTK+7XlzLdyzDqEcYz4zpTz950cQgRLFWNhcdTRpbtzhi7F26Qzc
 kMwHx4Hal49sMUWA/m6nAgr/Q3mmAy+iD/x5Q4pyKugTxjm2wVy5hLvTcsD3jQxto8wm uw== 
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.87.133])
        by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 3pu79qjhd4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 10 Apr 2023 18:17:58 -0700
Received: from mailhost.synopsys.com (sv1-mailhost2.synopsys.com [10.205.2.132])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 1CBEFC00F7;
        Tue, 11 Apr 2023 01:17:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1681175864; bh=zZCRsC/jgUUc6Aln++bBRTdqe0KTJbIMtdjeXgucSw0=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=X54PJ/P77ByvyOVJOrlgbdmYuPaPQtPjGEb9KOMGyTiMCv9K91EBp8fYWEEAw7zWu
         CvJTdolAjinHXlArcVsFhio9q55Ol+ZUBMsSBlB6UEEeJgbza/blKAoPFJTUUUbW8H
         NdOLPhPBykSuNjevjRplQFsMY2ORyua3arrq5uoM2meUnYWUsEi7tYUZnxnhpxq2Qe
         63F5V4R1FSuIK1Bb6pl/icmG7SG0uVO3ymTUfAG10sWuWlWqGb3Yvs5Jy9Wh23QbtY
         iGeCXaVoa5LavgRjUfGLKR4VExrefJieVa8lHdsHmUPYHAqqAUXgfoinuip8/MckCz
         QWK+uYsNDPVVQ==
Received: from o365relayqa-in.synopsys.com (sv2-o365relay5.synopsys.com [10.202.1.141])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "o365relayqa-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
        by mailhost.synopsys.com (Postfix) with ESMTPS id A70FAA0073;
        Tue, 11 Apr 2023 01:17:43 +0000 (UTC)
Authentication-Results: o365relayqa-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relayqa-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relayqa-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=ic1R1hvT;
        dkim-atps=neutral
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2047.outbound.protection.outlook.com [104.47.57.47])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relayqa-in.synopsys.com (Postfix) with ESMTPS id 5BCD322792C;
        Tue, 11 Apr 2023 01:17:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FdCV/QivAQjRB+FJBNdVhE3xDZRgFFmsTX3TH7gVhAAfAzOnRUF3cZEN2/5o/RyPKaSp+90nem+oTtYjvBXiJ0+cKhjzuObC0drbEzFMDCAZnVz5jp/HoYiyUEobSxD7nOE2Iir8l5MMgw+IbOMGboEd3jsxV9R1m1xXOTTP0n7OBhD0nGrG8vxrl/oLVsP6kd3QRGpfESeZnu6BMbg/jH1FzT4nAR4FVXcEt4YYCUc7d1QRnwoL+tcZ9ZqVDhclE+vF318tYFdEP3tJvxCf7pqILkO/8/P6n3SDgWT95RtWfGitFdl719psAegFdIbNRiWaWwzDz7jtLVtj77C6Sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zZCRsC/jgUUc6Aln++bBRTdqe0KTJbIMtdjeXgucSw0=;
 b=Ne1kjCRRiT/Wtz6wFw4Xys65V2os6NJTwQQq9/c75aPSfJ0sHsjAc2kkCx10TtbUxlSZTBJve9bjZjdrxyir3tWgiDO17mTsznPFY91+Bi+rbndVuweVDmz15wfyYJe0b0Kp2MEPznPXBrxgDs3oxwfJScYJOBjGdYozTGUpx3a6FO45M/2Zd7G+341MZf6/Hvca4j3khxBK25+ECKsae5vretK0DFilapMbBj4HKlycf24P7k50S9s/gjh527M2KeYtUHBLyi7OSMycBL1FiPstl254C36+El7m2ESx1QHrM3awiWOAoPLk3mz5NIfoKwRCBrkIIlQmmV4fLaSuSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zZCRsC/jgUUc6Aln++bBRTdqe0KTJbIMtdjeXgucSw0=;
 b=ic1R1hvTrB+fJjxDpUpB/u59KWmbdyo1TKdTzSGSn6vYBeRrFsexP4JugoaFubEYqgKEx/sYrapbC3R3vQsh+0eRbnOJ2K/bmexv9vCLM8obvA37nch6+oduOdFQwO4axKFp8PU1+3Hk0br8rdUWCI4D9+e0NyvGcP94yAPsxxg=
Received: from BN8PR12MB4787.namprd12.prod.outlook.com (2603:10b6:408:a1::11)
 by SA0PR12MB7002.namprd12.prod.outlook.com (2603:10b6:806:2c0::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.38; Tue, 11 Apr
 2023 01:17:41 +0000
Received: from BN8PR12MB4787.namprd12.prod.outlook.com
 ([fe80::a6ef:a9e2:ad28:f5cf]) by BN8PR12MB4787.namprd12.prod.outlook.com
 ([fe80::a6ef:a9e2:ad28:f5cf%6]) with mapi id 15.20.6277.034; Tue, 11 Apr 2023
 01:17:41 +0000
X-SNPS-Relay: synopsys.com
From:   Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To:     Johan Hovold <johan+linaro@kernel.org>
CC:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 03/11] USB: dwc3: disable autosuspend on unbind
Thread-Topic: [PATCH 03/11] USB: dwc3: disable autosuspend on unbind
Thread-Index: AQHZZsawWL0yFWHlA06LSJqKykoQs68lWUCA
Date:   Tue, 11 Apr 2023 01:17:41 +0000
Message-ID: <20230411011737.wcrxiqsuei2zvjse@synopsys.com>
References: <20230404072524.19014-1-johan+linaro@kernel.org>
 <20230404072524.19014-4-johan+linaro@kernel.org>
In-Reply-To: <20230404072524.19014-4-johan+linaro@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN8PR12MB4787:EE_|SA0PR12MB7002:EE_
x-ms-office365-filtering-correlation-id: 0256c175-9ac6-4419-2402-08db3a2a8bcc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wsJolMx5aefws9njvvhE5u3Cml/rkvNbpvPtr7w1ZBieD5DLjdAm6hVsNrJlbGEvmETjRNZeN7+9Saf1xO90ucCI/9jNOziy7vcUe2ZUJoyp1Xe/PZKh5l++iPbGIK438petIVOTmZBzKlRPZZ5uogibgyVymOiEwVn8zrKNMs3/jd9VjD6KMR4JduAawe5VHY3A4j2fjwO4V4J6ndh1pytthNARoX5XuFcQxmYIzDhccmBdIU1hkm/IkPxsFlJwGnL7zFRRoqxu0fIh2k8XtrtJ2U/kYFvtYKFmWPA3aJ7ajmIq5gT3y0LfhkSMsvRMP3sbpSLDEfNotpiXexQi+/qHBC2Q3WsfLBNzI8zu7t8vRTnaCGkM7CK/hdPP+uJa1HaM+5siuXpSrYFRkqefOvtGQ16s28ILHBZgU3+Ndf2HnaUfqt9u1e06Pfk/kuiZ6ABhifA3xrx3Ch0igpP/oy8RIHEWFrEPUNvzC9tlGtWX5KZMC401Meug65yIHc8y0gHHzj9Jk/hoRwFfv1RnKAaGEFIV2uRwuVCW3HDjZ3+t5U7TU92aNpw+LwyoKslj8UOlCgyfNqFdo+5zhFQz1vQfQByIJRWSdYrWAaMb0k0AudBSQcGQa1gT4yj8S/YQ
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB4787.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(136003)(376002)(346002)(366004)(39860400002)(451199021)(38070700005)(4744005)(2906002)(36756003)(8676002)(8936002)(38100700002)(122000001)(5660300002)(86362001)(478600001)(71200400001)(2616005)(6486002)(186003)(54906003)(316002)(26005)(1076003)(6512007)(6506007)(4326008)(66476007)(66446008)(64756008)(66556008)(76116006)(66946007)(91956017)(83380400001)(41300700001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UHpWazJscXlDUXIxQjNEU2dIa2F3R0RLd3dXaWUyQXlHR3RLK0svazRKUmI0?=
 =?utf-8?B?RmFTZjlFaC9BUUwwNVVGUXh3c3JiRjE4ZXR3QlM3N3BvcnhVZzBUSWNaNXBD?=
 =?utf-8?B?UkpzUjZrK2h1WU8zc2lkZkFEbTJFREdJRUxyUzNGRnhxZ1NIR1dBdWY3ajd4?=
 =?utf-8?B?WVNsUDVwNmYxdXRoenhuYlV1WWljWFZyU1ZsVjdORm1meWVZNzJBNmxhWXJD?=
 =?utf-8?B?cSswZWVGQ3dabVprMy96dVN1Y0Fyak54RUNwdXhjcGdMdXNyMjdCVlBnSEgv?=
 =?utf-8?B?M1N4N25RVTlSWUlqSlI2eG9KZm9CcktZcHcvTjhNZU9CcGRFQ0ZwZ1dnYWN5?=
 =?utf-8?B?TDdXMVBtUlQ1VXk3azNzVjRaZjNOQzRCak9YZ3EzeUE2OThsN1U0Wmk2SXJk?=
 =?utf-8?B?ekZtSkc4bGNZb3dTb0JzaDJqMEJ6NXNOdzBMVXlCZk5Nem9ybm41dVlNek9U?=
 =?utf-8?B?VEU5TTNTVVNJR2s3RXVsQ0t0R2t6dWhBTHYySi9DYkhheW1hWnZkOFZTcWNH?=
 =?utf-8?B?OU9JVTRIdGpDUFBvVWJERjJ2dkE5ekhlVUtYME43a25JQ3hQN1ZVcEQwSjd2?=
 =?utf-8?B?TXFkaTNpSWZzQmhLa3cvQm8weWtnZVlyYTExNHF1cGdQMVd2MmR4U245dmo2?=
 =?utf-8?B?UjdyejdOcjZmZG9NVWlnT0xUeEFibEY0d1FtdkFJd0QwVTVWc2JKZXhUMFAw?=
 =?utf-8?B?M3pvdTI0MnBTSlQ3c05ZN0tOZHMzelpoZkZmejVXMEw4QWJSWGo4Ylhlak93?=
 =?utf-8?B?Zm1mRUU4SkEwVGhZMFhYdGZzYUJNSkZYR0tEMWZ2OG0wV2wvMS91OXlzaHlJ?=
 =?utf-8?B?YUgrNEZtUS9HZDJUOFV1OUlpeVZYOXBBU0tLZm5ITUFEa2pQOGY4MnYycXM0?=
 =?utf-8?B?b0JlZWJpNXc3eDRTL08welZ4SzJ3aFRZNFgyOVkxaW9tZWRlZXhVOU0yVVRr?=
 =?utf-8?B?aTFkNklaSDVkWWpVbUJqMDNvWDl6MmRNdjBDbzRDR240SDgxU0l6Mk1yaXUz?=
 =?utf-8?B?VllETnREYzFjc0kzWmIzQ2dTbjFDMDJ4cFlSTHZzcWYyRjVCQ3BPa2JqTGJT?=
 =?utf-8?B?UVBLRmJYOEE2YWhvZklqa0x4ZXVMTDJldnQwb0pYWGplQzZvRW5wTDFnR1FE?=
 =?utf-8?B?ZHE4UG5SK0VHT1ZEaHUyMG95ZkJ3K0l6VFBLU3NFN1pndTZnTzZzdGtXamhl?=
 =?utf-8?B?aW5mMTllVWRicC9YUHVPcGJYTHZmNWZuRHl0czIvdDlyY2VrMVp0b2xaNEts?=
 =?utf-8?B?bm1YQXJ4RkZSaEZzWWZQRXExVVQvQjB6MXRuR2RJc1dDUndxam10ZitpWkUz?=
 =?utf-8?B?MzFSWDgrNzBObFZ3bXB4K2x1NVNEMGFxckVWVXh3UysyaW1xOFFqOE5acVB3?=
 =?utf-8?B?dWNSVGhtWDQ1TnF6YkozejNNSzE5RExoazNOdkRydWovdW14eFVwY3BUSXBO?=
 =?utf-8?B?RHZjUHJjM1FvbFJNWG43SERoZGhHVE5pWkFScVFnUmRKMFNsM0Joa3BxY2Rq?=
 =?utf-8?B?QjhndWl2aUlFdFlKeEJrUE1TeW8wWGZidmM2WTNKYmFNRWhZdkZoS0Q2M0h1?=
 =?utf-8?B?dDM4dkY2c3I5K2tyUDZXVmhJenc4aSthRHdzZW1ocXMxNlA1STFscHRVeEls?=
 =?utf-8?B?bFNFQjd3bEVxc0VQaS9vMmczL1paNDd2TUZPeUhUbXlBemhsMkZEaHZOeTh5?=
 =?utf-8?B?dEYzRHhwdVc4eTJVTDFqRE9IZ08xQnI3Rm5OL0lvSkpOTHdpMjk5VENYWmZv?=
 =?utf-8?B?SCtxREx0UVh6TDFhb0hEWGJTN1U4dmZ5SjYxOGNrU0o0MkROQ0k3WmR3aWZI?=
 =?utf-8?B?bktmbElsQnpheEh5akFzSlJGamdrY2tlYmVhdWpKRFZEbDRvcXJPdU5nTEUz?=
 =?utf-8?B?RGJFK1ArTHJOYUtzYmhDZFh2RXVlanltc2RNSjBTRHl0UmFpYlEyTlJhSWRl?=
 =?utf-8?B?b2oreFhhWnpQWG1qSEZRdG15bklUbDJKVXZEeTdvM1RacGlJTzQ0d1lwN2FG?=
 =?utf-8?B?elh1bW81dnNTblh2YzloeWZCWnVuV1FjdERTMmVPYUFFVCtJaE8zamtpazgy?=
 =?utf-8?B?bFNxQzA2VlhtYmdxMmxLSHUwTEFiTzRZZlhibU9pZVZLbDJMbk0yVHBsZnU0?=
 =?utf-8?Q?4fMPAN5CKAxIw8DxLOe2hEBSg?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <48062B052D2CD744916701E4902F2597@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: vvU1JXCsJec++0OlBltZTjUylilmcT43fM40UyVP3l2mihBVaoQw8S+vNrDR7/xrSKuigpIV9gMovyl9VYC6aAOcGN80WrhdYBvWGeXFPa6pILhT1mmxuJ5yu3yQzUXp5YY24wrX5s43S7VUCxPcYa6KTkvgSNG66z4t4eReeS9jXRbsg2ZxsvapmPeOUGil8jQ7qqlRfK6cXIesu1f1L/Q/XjTYNUDP1KSps4kgROgtKqIOkvGaICMXZEgAYKUhzVaPhH4SLL8HvtUST5zz9eoruagCVL7c3mTyecnRO5Il/roVpdoKpmXT8vKWya+YI8Wry4/tD9dm8tt7fgKBYdLVkNgaBSfglpiX0H3vmZ0UudAWgKdJnRORSrWt7wZ5OeawUZXcb75SU/cuARq1/s3hYRos7x//l7iP5veBow/JeGWAdF+FbDCDRK10ECv031cj3580G/neHQAZwk5AZK36/1qKYe3uwGvh30Gtxx6HRF0BFelUOLl8fQf1cZ1oZcUIBYY2vQiL0ZFfcMqQSw+SFT8HM60EBwHPrrPj3HOLxCrvOOau7oS3Gy7AmkVlOPLNJAornlFBttEpHLpN/UU56oTLQuZ3EK0YjMsPkj67dc1+iJtkg+yaKBumQfMzQWdoIZggLq1mdBWq88/b7BUCfd3TSwSnCn1Un7FPPyxqUIuWCnDVJi3lY84B2rZntSe1N3tVZwjQCHLZJgYWUYcDfnpmFKd5V87PKLM10XG0OSvqv8eoFmO1fx6jjFNY+G+fZ0rmEe3ZJH7cmGmfPLsA3sY1kxCKutub+afHttJH4uSSUH2+SaO3ZMV5VdUvhtu+JNBdwPMK66sWJ7hk+CdtdjP8PGUkhy2SyE/2GwqEXhv/zDCPaok/Mo7Qkqn0
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB4787.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0256c175-9ac6-4419-2402-08db3a2a8bcc
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Apr 2023 01:17:41.1162
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8tkTxIXrQ+Cn/IClcPMc5K3LJiIiSrkX3LtsULI6F5FWGpgYVGYo+zCU/Sdi0362kxBayPxCuUz9mSTQKhqrzA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB7002
X-Proofpoint-ORIG-GUID: 3LDF4V8ohJP7JnTsZrv97rdomD8LSrW_
X-Proofpoint-GUID: 3LDF4V8ohJP7JnTsZrv97rdomD8LSrW_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-10_18,2023-04-06_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 bulkscore=0 mlxlogscore=771 impostorscore=0 suspectscore=0 spamscore=0
 priorityscore=1501 mlxscore=0 adultscore=0 clxscore=1015 malwarescore=0
 phishscore=0 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2303200000 definitions=main-2304110010
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCBBcHIgMDQsIDIwMjMsIEpvaGFuIEhvdm9sZCB3cm90ZToNCj4gQWRkIHRoZSBtaXNz
aW5nIGNhbGxzIHRvIGRpc2FibGUgYXV0b3N1c3BlbmQgb24gcHJvYmUgZXJyb3JzIGFuZCBvbg0K
PiBkcml2ZXIgdW5iaW5kLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogSm9oYW4gSG92b2xkIDxqb2hh
bitsaW5hcm9Aa2VybmVsLm9yZz4NCj4gLS0tDQo+ICBkcml2ZXJzL3VzYi9kd2MzL2NvcmUuYyB8
IDIgKysNCj4gIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKykNCj4gDQo+IGRpZmYgLS1n
aXQgYS9kcml2ZXJzL3VzYi9kd2MzL2NvcmUuYyBiL2RyaXZlcnMvdXNiL2R3YzMvY29yZS5jDQo+
IGluZGV4IDlmOGM5ODhjMjVjYi4uNWIzNjJlZDQzZTdlIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJz
L3VzYi9kd2MzL2NvcmUuYw0KPiArKysgYi9kcml2ZXJzL3VzYi9kd2MzL2NvcmUuYw0KPiBAQCAt
MTk1NCw2ICsxOTU0LDcgQEAgc3RhdGljIGludCBkd2MzX3Byb2JlKHN0cnVjdCBwbGF0Zm9ybV9k
ZXZpY2UgKnBkZXYpDQo+ICBlcnIyOg0KPiAgCXBtX3J1bnRpbWVfYWxsb3coZGV2KTsNCj4gIAlw
bV9ydW50aW1lX2Rpc2FibGUoZGV2KTsNCj4gKwlwbV9ydW50aW1lX2RvbnRfdXNlX2F1dG9zdXNw
ZW5kKGRldik7DQo+ICAJcG1fcnVudGltZV9zZXRfc3VzcGVuZGVkKGRldik7DQo+ICAJcG1fcnVu
dGltZV9wdXRfbm9pZGxlKGRldik7DQo+ICBkaXNhYmxlX2Nsa3M6DQo+IEBAIC0xOTgxLDYgKzE5
ODIsNyBAQCBzdGF0aWMgaW50IGR3YzNfcmVtb3ZlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBk
ZXYpDQo+ICANCj4gIAlwbV9ydW50aW1lX2FsbG93KCZwZGV2LT5kZXYpOw0KPiAgCXBtX3J1bnRp
bWVfZGlzYWJsZSgmcGRldi0+ZGV2KTsNCj4gKwlwbV9ydW50aW1lX2RvbnRfdXNlX2F1dG9zdXNw
ZW5kKCZwZGV2LT5kZXYpOw0KPiAgCXBtX3J1bnRpbWVfcHV0X25vaWRsZSgmcGRldi0+ZGV2KTsN
Cj4gIAlwbV9ydW50aW1lX3NldF9zdXNwZW5kZWQoJnBkZXYtPmRldik7DQo+ICANCj4gLS0gDQo+
IDIuMzkuMg0KPiANCg0KQWNrZWQtYnk6IFRoaW5oIE5ndXllbiA8VGhpbmguTmd1eWVuQHN5bm9w
c3lzLmNvbT4NCg0KVGhhbmtzLA0KVGhpbmg=
