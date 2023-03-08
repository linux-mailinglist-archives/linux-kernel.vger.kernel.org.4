Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BC116B121B
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 20:36:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229878AbjCHTfz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 14:35:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbjCHTfx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 14:35:53 -0500
Received: from mx0a-00230701.pphosted.com (mx0a-00230701.pphosted.com [148.163.156.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AD7ABE5FB;
        Wed,  8 Mar 2023 11:35:52 -0800 (PST)
Received: from pps.filterd (m0297266.ppops.net [127.0.0.1])
        by mx0a-00230701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 328GIlBs001625;
        Wed, 8 Mar 2023 11:35:45 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=pfptdkimsnps;
 bh=rNzDYIy/u1ietY+oAOOpqi5+Tf2GBq6hxRI5WhXf49Q=;
 b=JPUAw3We1a96mkd33tAl0OS6U0K9X5BwMaFgNu72M2xUNK3mNk4eL0GuTLA1vjGQjmQB
 0jyGgc/W3CYBnpto7FRRsezFgDO+VjfIbNHL4P/Qnt8TdvHZacJ+MQLngDOqQT7BEj1y
 SgAuSShauY3NizgyJFnJJNsKf2d7nh8lkd6F3mhPDf1NmbhzZ9cH5rKU4PGNZe2nQMpE
 CiM6LT43pD65d5I5LgWbR6lWM8M+NCequxL1YQHdKD5OcDNLZyx2AhP81Q3PLnQPOfZp
 2wsXgq+WWkKN2rF3/FRWb0CQ+QbG9o86P3yg8dq5EFnqJ1nWXUj8iR8hYGYbtNYio3NV tQ== 
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.73.133])
        by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 3p6tgru74e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 08 Mar 2023 11:35:45 -0800
Received: from mailhost.synopsys.com (badc-mailhost4.synopsys.com [10.192.0.82])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id A1CF540095;
        Wed,  8 Mar 2023 19:35:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1678304144; bh=rNzDYIy/u1ietY+oAOOpqi5+Tf2GBq6hxRI5WhXf49Q=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=Qud/rrn1oeDYo3oTon11jOJNADYoIPnAp2mDDpzNP3JRc11IFcS54U2nzWfdV16EM
         SPegtzy+JmXuPfRZZQNUzDq9HhmB3E7mh63fPBVBABd0gnKsyaEwfTZC+/FLsrJr09
         +wxhPyJVRlNAuqwyDIXTmZmG/aEt+zU0m7+BTAAnI1zgB86vp7m30PZxsg0u4sWX05
         2V0iEnCmbtBjMS2pev7QnKb7mPGgjlwUIVP07WRyUSFvKD5JuUAm0Ggati4/GTLinB
         fnSPmIJol2TMyubQ1iAJEdF9bdd4MJqWsuvGbqxdBBeeLq4GCDo1BhyEbVKZC+U5HQ
         PBzJInm0w0jGQ==
Received: from o365relay-in.synopsys.com (us03-o365relay1.synopsys.com [10.4.161.137])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
        by mailhost.synopsys.com (Postfix) with ESMTPS id 02E67A006D;
        Wed,  8 Mar 2023 19:35:43 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2048.outbound.protection.outlook.com [104.47.66.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id A3B3A8379C;
        Wed,  8 Mar 2023 19:35:42 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=thinhn@synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.b="JpEM2tOU";
        dkim-atps=neutral
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nVrpRvHP0qCVf2NTOejqNDwZb+X+p4jO+I4D9wEYPg8Vr70kQlf9WVYJgtgCa6YhAxvDVaI+y7PnQvDzRBZTGi4kt1hAypMW8pmtT28yY7uER6BcYFbBroYH1Nkvc0G1aqyqEN52ae9r0F6dI7Mcsl0Qxkxp5DiCz0nuvcNSDqqgpCkKUp9mu/A6lAWw4/4kf0LYk52c3dygsgpLphx4FTux42gSVrEqiQhDwAQG0UYPpfLQSUZgyx3K9bdfd3ONOtGYkoFE1ZAspxsdCfPOiw4lzFPImFFKdI3wYdl1wlw1awhdqjqcAZ9+imaQp5wHSDXh+bd08Tf6GIXfozgzuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rNzDYIy/u1ietY+oAOOpqi5+Tf2GBq6hxRI5WhXf49Q=;
 b=ApoA5QUTmzCg0Gi/0/JP7f/taTSEEf5CoG1mRVKBa4sF7/aJVPGB5NTLB2yP7cbbWkiAsK+yOJUFgGPATjcbhaBDrVVVPBY1Q5ojsG8aH5TLZdVowmAqJuiOLt/5qhwhGXiWbu+a+qGNicte9wnRUGapIRVWRs9C2acIaIdNEaDpKViP3RIV0ti2qx6dhXu33Nf5WcDsEp1pBNsUko1PpnyQPhWCzq9hDtm+l9d4NgVci0p8B3y4JaBC/Fu5iWoFpvFQSMui4yLagayLcLAwLi6rPVOFi7MX1zZjIYMyoQ9CZbjUJfwWAydITbygzlSH1O10dBk3g/SBl/iqh4HIqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rNzDYIy/u1ietY+oAOOpqi5+Tf2GBq6hxRI5WhXf49Q=;
 b=JpEM2tOU4bZmUBcFGCFZn4SNeOI3/tL5Gw+gkFlZsxOhGIHElWf/H+rxyf8mR1AlJQ7hgWj/IHG8jHDPrkOF9XW/4MhfpQ5/+TgsDbhqp73C+e/XdgGp/RBcZr11cvibFoe5N4Uyqsrtk+xhrFmsKvn0wus0fRMLolPDYWloD+Q=
Received: from BYAPR12MB4791.namprd12.prod.outlook.com (2603:10b6:a03:10a::12)
 by SA0PR12MB4575.namprd12.prod.outlook.com (2603:10b6:806:73::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.29; Wed, 8 Mar
 2023 19:35:40 +0000
Received: from BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::3161:c44d:8bb3:423f]) by BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::3161:c44d:8bb3:423f%3]) with mapi id 15.20.6156.028; Wed, 8 Mar 2023
 19:35:39 +0000
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
Subject: Re: [PATCH v6 2/5] usb: dwc3: Add remote wakeup handling
Thread-Topic: [PATCH v6 2/5] usb: dwc3: Add remote wakeup handling
Thread-Index: AQHZUFoWtCHrQavG30OBTVtOXtbsiq7xSZgA
Date:   Wed, 8 Mar 2023 19:35:39 +0000
Message-ID: <20230308193534.lvjitqm553xhmz7w@synopsys.com>
References: <1678127568-10609-1-git-send-email-quic_eserrao@quicinc.com>
 <1678127568-10609-3-git-send-email-quic_eserrao@quicinc.com>
In-Reply-To: <1678127568-10609-3-git-send-email-quic_eserrao@quicinc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR12MB4791:EE_|SA0PR12MB4575:EE_
x-ms-office365-filtering-correlation-id: b5b24970-e0a9-45a0-c370-08db200c4c13
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: FQ+BUPLnN/jbDo7Fh0M7wkJWjFOMCvsJxA7tDlkBQ53ZIulJXJJpexAix6IPbjIHAD4eaQVqnthjlQkA/zVYnkkZYSZQQzycxio27DadFCDPDZDF+5By+CIvrxZOfuoI99nAq3SuF3tFPhBgPtpxhNCyERUjpYXgMDMYsEftwEARKOVLkHLbr+Ks27IxC3uyzwPU5qFiAY36qp9GRSKxekSUfCPaCiexsCIZvl1pawQPpRufamdNpMMuXrnBkSOG2lWbrkbZ3NrNym2WhFfwmsEanj8JUgjeEx2/MC71iNGbQKTkCitG1w9SR9T49EYKQyMruA9aVAMkD1h6cTKBNaRWTVsZDPv1LwVvmxOduJUaeUvcb+KgFCgjdTJPoj+iwQtTO6pUUfdl2ODBhnngNyV5zq1ogT2+qxxV70hu/Z5PKlkOYr0uW+RsAzrJQX3lqC2D8B9HIOyoOYJ3nbCFgOPnRb58+p9elrQ2XFOUcxCcm7ss751Lw8XcI/tB849RmoZjVxGaLBBgCFNDfe/efJ+GwQw3dVy3aLgSRTh7ZxaUPJ2K+GhAMS/jVv5L+FzZE1nnAe3mjoli8KxwI9tTzIhVnyDoH9nT4oGLNdxV4Mmne9Q5vBvtFU6sK06lS4xpf7MdMM8hyTg3revMI20s1yzHKZ1neKy2h8qgbJBTp7qEHGZA5LaRe3Q2RRGq01bUCQx0Vrg9UFTqOU9wuvw9Jw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4791.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(346002)(39860400002)(376002)(136003)(366004)(396003)(451199018)(6486002)(54906003)(71200400001)(36756003)(4326008)(66556008)(66946007)(66446008)(76116006)(6916009)(64756008)(8676002)(66476007)(8936002)(2906002)(41300700001)(5660300002)(86362001)(122000001)(38100700002)(38070700005)(6512007)(6506007)(1076003)(478600001)(316002)(83380400001)(26005)(186003)(2616005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NFlzRlpOQzF0dWhaSjlmcE4xZEVRUDhhYnhxUVUwVHd4aFhvVEtKMXJ3dmZH?=
 =?utf-8?B?Zm1xZkZuRUlKK0hnQ2VVSFcrNHJZSElQemo5SjR6MFo1NWpMWnV5SWRlSjVy?=
 =?utf-8?B?ckRhM1kvRTFrRXBNRlQ5TzBnaTZZY2xvcEUwQVd1eDhPS1k2RXp5OEpZYTZW?=
 =?utf-8?B?eDdWQzYvemVSTDNVN3FyM2pJR0sxN01uN2c3Yk9YMXo1NjRqckNEWVd0VDl1?=
 =?utf-8?B?WURCQTFkdzJVbFA4Zk9NQk5oYnFRTTJjN0tXaUZQSDVUOXB5cnBhZUFyQjVk?=
 =?utf-8?B?T2kzd0pCNlFueE5YUHBKSG9vcFk2RnA0cUIvZ2UySmY0RlZtWktMOFA3NnJS?=
 =?utf-8?B?WDFQVzNiVGw0dEhMakQxdnNKcUVqZnhNRlkvQjFXM0c4b1VzUEtpYnQ3Zm1G?=
 =?utf-8?B?ZE1kV0VTMFBXb0QxTy9GSVlOVTdNbmhhNHg4aGdIbU5TSElHTlhSKzhseW8y?=
 =?utf-8?B?UnFyTGVQSXlvaUxiSXR5Y2dLeHhnSmpCaDkwcytsT0VJeVd4V0h3N3F6elZz?=
 =?utf-8?B?aGk3T3BndmFzSU9nZGFWUDkwSWFiVStJOTU5SXFtYUNXa1BUL2swNXFQNWFO?=
 =?utf-8?B?MkVTTUVwdURHWlYrb2FCenA3MXN4RzAzenNkSzB3a0tQdnlvd1lkR1cybXFj?=
 =?utf-8?B?a2dsVkw1cjNQK0xqc0twb3ZQck5MOTBpYTBvUU1ieVZ0RGtqdUVVQzZMSkF0?=
 =?utf-8?B?OUpSZU1FUmVTTVJhWTJWS0Z2d3VCY1RYWU1ISHZjbUYwdHBIM0V1cmFoK1E1?=
 =?utf-8?B?aEVudHYzcFJLY0NZeHVUREgvQ0pFSUpFMHpRQURhZlFKcDNBbDNseXBXWmwv?=
 =?utf-8?B?RFFtbVBEalc5eTVRNUVyY1p1NUZwYmkvaitiKzFZcGNvVEJMYTJoeEtnQ2Zm?=
 =?utf-8?B?UzBuNWpxSjM0MGEyVHpQbGZvNGg3eUc3ZGl2VHNJc2NHZGlXNU96RGlHeUto?=
 =?utf-8?B?S3NNSEdWc0pNTmRLN0xZMXQ1aDZCaHJCaUNoTWdoS2RoZ1R0MWgwaEFQMkhL?=
 =?utf-8?B?NmYydFJabkRvSkhtN3RTdEpMc3lmWmlSTnovU1B0NTZZaDlkMHRzb2RiVDBp?=
 =?utf-8?B?c3dyaEM2TnU2clVPeVZVY1gwVzJIRTgxekZXTnUrSTUvOWRNb1MvcVNRYVRD?=
 =?utf-8?B?RnZ4czJ1YW00SnFrS0tBMEh0Vkpsa0xUczF2M0lDZldxeENrbzY1UEJSdnFs?=
 =?utf-8?B?REVoRUs3bGhINUR4Mlh2NkhyeXZtY1U5V3dUaE1SbXpsS1VBM0lDYUJlc21w?=
 =?utf-8?B?NktDR0pkVDV3aVNIWEwvSGEzNlBDWVVqb2kvcDFpdURPZmdObHB6WFhXUEVn?=
 =?utf-8?B?RmhQQitNTml0d012NnA5eXdPcEpRSVFQMHhGdlZuS0dsaDhZbFhxZmlzdFl5?=
 =?utf-8?B?TUJWVWVpc3JhczV4eWhBa3FUZTBrZGlOT05Nc0drMGxtZW16bElEUDM5SSs1?=
 =?utf-8?B?aEZsNldIL0wwN3pHZHdtSittNTM1b0xpaW1lZXYrb2RuSWJOVnpTQWx0Y3B5?=
 =?utf-8?B?TFBwWDJnUExRQWtsVUxXUG1WbE91T2ZBcWxrL0pCT3pBV2dtZG1FRFE0MkVC?=
 =?utf-8?B?aE8wR3hJTmR0SHZBN0toYzBGdTdtajZWT2toRm44emlmRU1XSWVlN0VkV1NP?=
 =?utf-8?B?YW5PZGNCWWo0RXRHMnVPemlVLzNiN0l4QnRHN3IwYTVDc3NQRGhjMUhFY0Jy?=
 =?utf-8?B?MFEvTnRZZEMrdFptbnhoS0NUMkxocFFwc1NVMk9nVDg3WE5OMFliUVZVNzRP?=
 =?utf-8?B?eDhjMHEwNDUraUZ2UXJkdUlZcmozMnQyMG0xTllyT3pRTUc1UW5XK2RycHlT?=
 =?utf-8?B?MTI4Z0Zqd3BiWUg5TW94K0hYTUhZUERNSFljcjgwODNOa3NiWGhGcncvQlV5?=
 =?utf-8?B?ZHVDMVdoS1V6UXo0YTNRazMyR253N00xYm9WamhLQ2lRWWhSMytLWDl1ZGxq?=
 =?utf-8?B?TDFrbHpyVTErZ0dOdUc3QkxYbEFuQmp5QllFWHJNNGNKQ1JzbC9IU0VDdHlX?=
 =?utf-8?B?Z1h0YWlUMXpRamtXUXhPRlR6UjRKd1phbm5CV3U4MEZnc0s1dlRRdHR5WEVF?=
 =?utf-8?B?dEh6Z3pkL2R0R2FjWG1xT1JOSGRzWFlubGtDYys0Wmt5K21ScUVqNitMZWo3?=
 =?utf-8?Q?wS3ww84Lud9o/mIIqtdbcRPEF?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6754A27ED842CC46B9E18C4FF6C170D4@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: erYeWtzGidJSOYnoPCw1+3M/htie/3EzxIt9hnqaykQfrtt6hVX0zMx9oMTTtmbSuAV/uCCSOKPbt7UXqZyhxNzKBNsCoI1C1p2wXCsgG3lO9QIHzEJzcJFxteFpZ/aZi7H0D3c6DkIGjsFYwgfzaBPx4uN8eihiljOzRRBKpBfa7z83+25AzAu4d2TXuGbFvfLcS4McvtlOOU/aIJ59/Jq6O2DZ+MVXZ+DbW3P7InN8EZ6eiustKBiV/WNttF4Q+baT5xJ7slbso3ntNB67ox0T/GcAaQmrrGAyw3oe0NEs9a+yztMlToLWs4VYtRLsy+kdo89zcmAqWFnZfBbKfvb/22S2R70qc7MPA9P7J2zBLOyEaQpJpYWYLoR/uBM5WMe/PJnhHZitg1NS9HCmlRwEfL+wZYkkf0iyTvlRMlSQVB/LCYRHwpP8gVUgo2uowJAsltHlsbutLJIvhILyITkO13zg01PsnefSxOmhcoDzqD846Q/htYuG+Sc2hy88LFfp3h1zpZhLyL+jT4T8QvuhNRZjiRdit0aK8MMgWIg1iW8SyiT/h1E2Nrv9lX8ZnA5RKzw57ADse/24N36lB/bOzynh4yKlNboiLF2AOazyyugz9eIUqzB8zmnLjPC0zegn6LEfq7eHXZOerhz8TqdCuBUxtaEsEqA5DLsqUBFYwniHRfJTYgv0J6T584OzzP7lALCbSdw0udUFdJMQE16B5yZB9H11Qrj5sI02Dk+431p6mQKnHo/djYZlGZKHtLtbQ15DPCSTCc3dG9f6Ot2MIGh/hBAIKWXQ2WAnzRy5wTxT4mMdh1GWZeJj5ZxQH2zbJU384tpIG6oZfJ0PBCz5fQSym5ebD4Jal5J3Otxfpr1OWiI39rNy1aT9fvVibrvmmEecqfATel44UMjwFY5BV7GZOLcFPzMoi4hyquc=
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4791.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b5b24970-e0a9-45a0-c370-08db200c4c13
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2023 19:35:39.0804
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 95mdfTePinnSmEX653To0j8BH9QgurY3g+yAWtCrfSUCssgW7uzficOrnFiMX0W/7sc3EACURLuUM4c/HhGKPg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4575
X-Proofpoint-ORIG-GUID: 8P1yeV-S-22YoyVC5eUeGrvuNbH1btGW
X-Proofpoint-GUID: 8P1yeV-S-22YoyVC5eUeGrvuNbH1btGW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-08_12,2023-03-08_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 lowpriorityscore=0 malwarescore=0 clxscore=1015 adultscore=0
 suspectscore=0 impostorscore=0 priorityscore=1501 mlxscore=0 spamscore=0
 mlxlogscore=832 bulkscore=0 phishscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2303080166
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCBNYXIgMDYsIDIwMjMsIEVsc29uIFJveSBTZXJyYW8gd3JvdGU6DQo+IEFuIHVzYiBk
ZXZpY2UgY2FuIGluaXRhdGUgYSByZW1vdGUgd2FrZXVwIGFuZCBicmluZyB0aGUgbGluayBvdXQg
b2YNCj4gc3VzcGVuZCBhcyBkaWN0YXRlZCBieSB0aGUgREVWSUNFX1JFTU9URV9XQUtFVVAgZmVh
dHVyZSBzZWxlY3Rvci4NCj4gQWRkIHN1cHBvcnQgdG8gaGFuZGxlIHRoaXMgcGFja2V0IGFuZCBz
ZXQgdGhlIHJlbW90ZSB3YWtldXAgY2FwYWJpbGl0eS4NCj4gDQo+IFNvbWUgaG9zdHMgbWF5IHRh
a2UgbG9uZ2VyIHRpbWUgdG8gaW5pdGlhdGUgdGhlIHJlc3VtZSBzaWduYWxpbmcgYWZ0ZXINCj4g
ZGV2aWNlIHRyaWdnZXJzIGEgcmVtb3RlIHdha2V1cC4gU28gYWRkIGFzeW5jIHN1cHBvcnQgdG8g
dGhlIHdha2V1cCBBUEkNCj4gYnkgZW5hYmxpbmcgbGluayBzdGF0dXMgY2hhbmdlIGV2ZW50cy4N
Cj4gDQo+IFNpZ25lZC1vZmYtYnk6IEVsc29uIFJveSBTZXJyYW8gPHF1aWNfZXNlcnJhb0BxdWlj
aW5jLmNvbT4NCj4gLS0tDQo+ICBkcml2ZXJzL3VzYi9kd2MzL2NvcmUuaCAgIHwgIDIgKysNCj4g
IGRyaXZlcnMvdXNiL2R3YzMvZXAwLmMgICAgfCAgNCArKysNCj4gIGRyaXZlcnMvdXNiL2R3YzMv
Z2FkZ2V0LmMgfCA3NiArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
LS0tLQ0KPiAgMyBmaWxlcyBjaGFuZ2VkLCA3NiBpbnNlcnRpb25zKCspLCA2IGRlbGV0aW9ucygt
KQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdXNiL2R3YzMvY29yZS5oIGIvZHJpdmVycy91
c2IvZHdjMy9jb3JlLmgNCj4gaW5kZXggNTgyZWJkOS4uY2M3ODIzNiAxMDA2NDQNCj4gLS0tIGEv
ZHJpdmVycy91c2IvZHdjMy9jb3JlLmgNCj4gKysrIGIvZHJpdmVycy91c2IvZHdjMy9jb3JlLmgN
Cj4gQEAgLTExMTAsNiArMTExMCw3IEBAIHN0cnVjdCBkd2MzX3NjcmF0Y2hwYWRfYXJyYXkgew0K
PiAgICoJMwktIFJlc2VydmVkDQo+ICAgKiBAZGlzX21ldGFzdGFiaWxpdHlfcXVpcms6IHNldCB0
byBkaXNhYmxlIG1ldGFzdGFiaWxpdHkgcXVpcmsuDQo+ICAgKiBAZGlzX3NwbGl0X3F1aXJrOiBz
ZXQgdG8gZGlzYWJsZSBzcGxpdCBib3VuZGFyeS4NCj4gKyAqIEB3YWtldXBfY29uZmlndXJlZDog
c2V0IGlmIHRoZSBkZXZpY2UgaXMgY29uZmlndXJlZCBmb3IgcmVtb3RlIHdha2V1cC4NCj4gICAq
IEBpbW9kX2ludGVydmFsOiBzZXQgdGhlIGludGVycnVwdCBtb2RlcmF0aW9uIGludGVydmFsIGlu
IDI1MG5zDQo+ICAgKgkJCWluY3JlbWVudHMgb3IgMCB0byBkaXNhYmxlLg0KPiAgICogQG1heF9j
ZmdfZXBzOiBjdXJyZW50IG1heCBudW1iZXIgb2YgSU4gZXBzIHVzZWQgYWNyb3NzIGFsbCBVU0Ig
Y29uZmlncy4NCj4gQEAgLTEzMjcsNiArMTMyOCw3IEBAIHN0cnVjdCBkd2MzIHsNCj4gIA0KPiAg
CXVuc2lnbmVkCQlkaXNfc3BsaXRfcXVpcms6MTsNCj4gIAl1bnNpZ25lZAkJYXN5bmNfY2FsbGJh
Y2tzOjE7DQo+ICsJdW5zaWduZWQJCXdha2V1cF9jb25maWd1cmVkOjE7DQo+ICANCj4gIAl1MTYJ
CQlpbW9kX2ludGVydmFsOw0KPiAgDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3VzYi9kd2MzL2Vw
MC5jIGIvZHJpdmVycy91c2IvZHdjMy9lcDAuYw0KPiBpbmRleCA2MWRlNjkzLi5mOTBmYTU1IDEw
MDY0NA0KPiAtLS0gYS9kcml2ZXJzL3VzYi9kd2MzL2VwMC5jDQo+ICsrKyBiL2RyaXZlcnMvdXNi
L2R3YzMvZXAwLmMNCj4gQEAgLTM1Niw2ICszNTYsOSBAQCBzdGF0aWMgaW50IGR3YzNfZXAwX2hh
bmRsZV9zdGF0dXMoc3RydWN0IGR3YzMgKmR3YywNCj4gIAkJCQl1c2Jfc3RhdHVzIHw9IDEgPDwg
VVNCX0RFVl9TVEFUX1UxX0VOQUJMRUQ7DQo+ICAJCQlpZiAocmVnICYgRFdDM19EQ1RMX0lOSVRV
MkVOQSkNCj4gIAkJCQl1c2Jfc3RhdHVzIHw9IDEgPDwgVVNCX0RFVl9TVEFUX1UyX0VOQUJMRUQ7
DQo+ICsJCX0gZWxzZSB7DQo+ICsJCQl1c2Jfc3RhdHVzIHw9IGR3Yy0+Z2FkZ2V0LT53YWtldXBf
YXJtZWQgPDwNCj4gKwkJCQkJVVNCX0RFVklDRV9SRU1PVEVfV0FLRVVQOw0KPiAgCQl9DQo+ICAN
Cj4gIAkJYnJlYWs7DQo+IEBAIC00NzYsNiArNDc5LDcgQEAgc3RhdGljIGludCBkd2MzX2VwMF9o
YW5kbGVfZGV2aWNlKHN0cnVjdCBkd2MzICpkd2MsDQo+ICANCj4gIAlzd2l0Y2ggKHdWYWx1ZSkg
ew0KPiAgCWNhc2UgVVNCX0RFVklDRV9SRU1PVEVfV0FLRVVQOg0KPiArCQlkd2MtPmdhZGdldC0+
d2FrZXVwX2FybWVkID0gc2V0Ow0KDQpDaGVjayB3YWtldXBfY29uZmlndXJlZCBoZXJlIHRvIGRl
Y2lkZSB3aGV0aGVyIGl0IGNhbiBiZSBzZXQuDQoNClRoYW5rcywNClRoaW5oDQo=
