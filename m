Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B12B56A76F7
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 23:45:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229825AbjCAWo7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 17:44:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbjCAWo5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 17:44:57 -0500
Received: from mx0a-00230701.pphosted.com (mx0a-00230701.pphosted.com [148.163.156.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9089E1A65E;
        Wed,  1 Mar 2023 14:44:56 -0800 (PST)
Received: from pps.filterd (m0297266.ppops.net [127.0.0.1])
        by mx0a-00230701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 321JG5r9010013;
        Wed, 1 Mar 2023 14:44:54 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=pfptdkimsnps;
 bh=edtlPnk6OgF0Bf8nyHrMhEM9eOtw3hjowYj+Xk8rhLw=;
 b=gO2QONNC+31TUau+rEESumLzlo2OkcEDyj9wSAyhs3eOZVcTFI9MIvcfqO6ZxYl5NUQv
 Qi+GHkt/ALCFzO56YAwO4/NrE8gueI7fDQPeD2sZ7NexZUY+YesT+q9+PPbjQW4rOu1M
 5keUllq5wLqiXyEK5MJkPF2qlcQ3gP7zrBV4TZ2TCX1slT6sm1PuP3NfnNEkglwToDk3
 +uE9+zyLbT81CFHnXWyIvKbWp/3ZchbpEH685ohwWhQTfErg8kTxsq0dOyLYswasf2I7
 eCBDB1tpmm3Gw7l6LAi4/xEQIrdvlqCo/2HaOzz/E9NbyiM2AnBKjRHSuFjgLZX+CPEo Kg== 
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.87.133])
        by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 3nyjfdneau-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 01 Mar 2023 14:44:54 -0800
Received: from mailhost.synopsys.com (badc-mailhost3.synopsys.com [10.192.0.81])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 8449CC00F4;
        Wed,  1 Mar 2023 22:44:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1677710693; bh=edtlPnk6OgF0Bf8nyHrMhEM9eOtw3hjowYj+Xk8rhLw=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=C5N1RDDxuoXQyKxc8B8QgPylf/MjNxTxD11jG9JW8ftblC4mqu4B4MkK1mAZCz88f
         2FfqkElcIxklRnKXK94LUdWiMX1n4wNwkjtryKQfqXTemNFM+7jbL3uL21hRelfzxq
         g2OILexpoXDplUWC7ZvpI5wvuGYzPpQCl4UTJHERzSbGvLKCOBxJCEwFUGc8RYH4Xf
         O2Be+eS9FU6lcDBXVbwHOznFI1P8/3aESZWxjsKNkkvUBSnUoW4B//ztuAjNEOg4vA
         xkmnSOJDfPNtg52Vc4bmu/BisiR7AbVWXNd+3Ifogc4bRFwuIrpJxMLgP0XcSHUaox
         wJcxTFt7cTfsw==
Received: from o365relay-in.synopsys.com (sv2-o365relay1.synopsys.com [10.202.1.137])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
        by mailhost.synopsys.com (Postfix) with ESMTPS id A13D3A0063;
        Wed,  1 Mar 2023 22:44:52 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2176.outbound.protection.outlook.com [104.47.57.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id A8018400B9;
        Wed,  1 Mar 2023 22:44:51 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=thinhn@synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.b="ja4iuBqY";
        dkim-atps=neutral
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hIeAEHLlWxl6WPBJkvHrTOeh0/rzqIarInX4z3Ell0J7N8dTvqZOJM9lJzC0M6/LfCiZ0pFmdUGrfHg0G7c9fiWM8apDZyYgrkNBjHTY0QXa6WHlDCaeOtLQUn9eQU7Ssn0G/l7IP0H4C+rjclhUClQ34Sj1ofBTHyQV2FHKU+c0mK51r61MinO1bSQ4FPPi83piAAS2J4gLrez9ndFOjS+zP7k/860iBChzttsT5iFXHKFnkkrosKR4hFUICQBDQ3rj4OFdU/QYglwB8Ip83nd9JAnber3yUJetxISGniZnblyfUm5uEkwt3fVQiw5n1KeKfKIr7iL6R8n0L24zHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=edtlPnk6OgF0Bf8nyHrMhEM9eOtw3hjowYj+Xk8rhLw=;
 b=P093QFjKwucoBMpqhZCaBKB7+FWOKSI7bwL7xkPJzTBM24RyO9p0rpMc/QNoxguJwCLLfvP7rKax1P6jWQQlp7uUvWdbgA/5ePplZcm7i38vPiFT184dSHNIPoZPVxOlnQX6Dle4NjHy/5MSLtfEBCIeXqhzyf129es/uQb0bbNDmBckYvGpkrMiAuSxHkBoos7y497UbDR4PW9wzBiZWhD2cFrpmB/z1vzcU2ea6TIm1Lvg1YykTyLU0iATzmmBKSmcSFLpRyA3Q7cvfAt6Id7lKXoeifqReyrzBeMllEmIZ35K/+2xKEbyRcr0GnAj8WNufgyn0e5QRWpuCUsiUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=edtlPnk6OgF0Bf8nyHrMhEM9eOtw3hjowYj+Xk8rhLw=;
 b=ja4iuBqYm/2Y7zmFhG9RMYY7UFvEJ66IeNzoPzW0OwH2yLpOxLFcK6zClQU8mGxWqisrohKiSfg9Yh+yFWJHbf+BEoDueZXn9MWJkgdkW2fR01nyHuVSYnb4PlGuNbSY+ax8FwhXL/BDD1OJLLitHNyy38ioN1wWzHcgVx+aqwA=
Received: from BYAPR12MB4791.namprd12.prod.outlook.com (2603:10b6:a03:10a::12)
 by MN2PR12MB4271.namprd12.prod.outlook.com (2603:10b6:208:1d7::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.17; Wed, 1 Mar
 2023 22:44:48 +0000
Received: from BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::3161:c44d:8bb3:423f]) by BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::3161:c44d:8bb3:423f%3]) with mapi id 15.20.6156.018; Wed, 1 Mar 2023
 22:44:48 +0000
X-SNPS-Relay: synopsys.com
From:   Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To:     Wesley Cheng <quic_wcheng@quicinc.com>
CC:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "quic_jackp@quicinc.com" <quic_jackp@quicinc.com>
Subject: Re: [PATCH v4] usb: dwc3: gadget: Add 1ms delay after end transfer
 command without IOC
Thread-Topic: [PATCH v4] usb: dwc3: gadget: Add 1ms delay after end transfer
 command without IOC
Thread-Index: AQHZS+6CCAqRijckm06uhZF8XEe2eK7mhvmA
Date:   Wed, 1 Mar 2023 22:44:47 +0000
Message-ID: <20230301224445.4gmkrhw467lopstg@synopsys.com>
References: <20230301033234.21024-1-quic_wcheng@quicinc.com>
In-Reply-To: <20230301033234.21024-1-quic_wcheng@quicinc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR12MB4791:EE_|MN2PR12MB4271:EE_
x-ms-office365-filtering-correlation-id: 1eafa0cc-e8b7-4781-8bd5-08db1aa68f25
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: uEmDkDKYW81bTnaPrtYHrcyWJe/xOc55c097HgTm/vxruR3UOTYf75XEZA2GmmvvF7tZwrtNX0xfs6/oLjvTsEJLdlAb94iEtHRm8eRckvme7PP9duXRnEbzNleO73gloX5TKxtVz5cxg484dyczdjfOkzmQRiEboyHoGSA0gAneGARE2SfS3giEvxdhFwq6/x4OXCOw3/MhATUlMrA/rcnMLcWC+USbXwyOraI9W5VBniTfUH5WNCTgvKDIwPX1t+iy+TU8XHSgC73ZSIgH8Tm6ZuEWtQ6lq53mv443B/ro0wM2wEjzPr5q8pEKVDdd28SlPcmU6Tmb3Y44HEBqqhqGrxhaXXurVLplZA6XRdrOUzif3Jo5ojRlsdBzoCHgqlL/wEJSTWfz294ccYBiPDC8m+1UJUCnIjW4p8V5/+mxd8bdBo4rhNDtns1Utw0+ZslKUGhmiW2+zWtqNtQgiRpEprOQ9tW4OQNbuAofM+1rtRyaXsEPELXvc5wrvAF2rgijgBxRrmKlV87r5GLUGLaJ5U/53ng9dK+/1y1UUa4DAHV5k+q7pQ5M8B0babXlU57SjFBiXCv0cUaNzvU8UAEC1fCkO6SrWdlcJcwpxEnX1H1PYFoZfNEJfjUd0eDja+WWhqgiTLBp0rwdTeG0Zh9boyTjrvLDDtDoR+F8a5OE0t0awZ8fTAAiQKKGhFIe4fW+xkLh7Omkni0kEL9ZmQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4791.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(396003)(39850400004)(376002)(136003)(346002)(366004)(451199018)(5660300002)(6916009)(64756008)(66446008)(66476007)(4326008)(8936002)(36756003)(83380400001)(41300700001)(2906002)(66556008)(66946007)(76116006)(8676002)(316002)(122000001)(6486002)(38100700002)(186003)(26005)(1076003)(71200400001)(6506007)(6512007)(2616005)(478600001)(86362001)(54906003)(38070700005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YnVaSE9uK1h6OUNTeFBrVUFlU0lKclFnYzZRbEtCWHBPTzRXd3FzUHg0NXVz?=
 =?utf-8?B?K3phVnpUVWpnWkJWalp6bFB6aldJVGwxV3F0U1J0Uzc0Ty9wYXl0N1FEa1Ft?=
 =?utf-8?B?aUJqbDBWSjA0V1FCWGhYYitsb2w1Q1laSW1oZG96RXQrbVV0ejYreXlIS2pI?=
 =?utf-8?B?NzZ1bml5dktjV2ViS1J6TjlZVHZENEZlTEFDYjVMMERvSEVkRTVBK0U0Ti9p?=
 =?utf-8?B?Sk1MVUNmT3V1UE1uODl0czNnZVpxZ0VQMkZDUVhXckZQRkxQQ1pyZVhlQ2Yv?=
 =?utf-8?B?WG5CYVdTV2FzL2xDaTR2cVJhNzFIbzNTalVsVTJzUEY1WVd1RHhITFBEajNC?=
 =?utf-8?B?KzFXeE1XNjZWQmtTRjRNTldXYXROTVUxNmJQYmlEUWJSUnEydXF5SXVXL1Zz?=
 =?utf-8?B?eFZldWF6RHlVNmUxWXhlRi9HWHd0ejdyWUdWMFZGSmZEVkVpaUZjTmVJOEsr?=
 =?utf-8?B?QmlRTi9jSVhxSlFWMXBvZ3FybnVOSnc4RHlhWEhZNGlST2NRSnQvS1hsMDRD?=
 =?utf-8?B?NlNleVo4a3hpeVJaNENjTmg3OS9WTnJvK3VuZjgwOXFjRlRacnNEVGY4QjEw?=
 =?utf-8?B?OVdjTE9SdXNBZ3JqTnp5L2ZRRDBHYUpDeHhjVGZ2TlNBVnM3VWc3eVhvQzdr?=
 =?utf-8?B?aG9Ja0ZGdFhrMForSlRMaU9OWHptakorV3huNW9KT1dyek9WcjhwUDVramJR?=
 =?utf-8?B?WnNjVnkzcnQ4M3lhbnozc0d3b2JHZVFKYTRVYWtuZFp5SDRWQlRBNVEvbEd0?=
 =?utf-8?B?MnBlZ3FjR1FVWHh6T2tZVC85SDE2ZlR6aEVRWklzNEtvcmlRWFhLb0QySWZ4?=
 =?utf-8?B?cEZEbUsxWkNGUno2c1diUDJrV3QrYko2dytLYUo1ck93SGNjeGhEd0dldjFo?=
 =?utf-8?B?WktzaTF4MEJLYklneHdCa1YrSWxyNE9JWnEwck9JZmNuNm16cFMrWnIxNmZK?=
 =?utf-8?B?YW1PbGFEeEprc0V3TmRoeVJkZUYzSFdEUzUwOVNmSXRraGdGeiszZnk4Y0xa?=
 =?utf-8?B?U2ZkdkZTeVA4OTNPY0RpeE91S3B1RW16R0pLNEd3L1JEZENZS2h5M3p0MHNr?=
 =?utf-8?B?QWNTSWJST1pJV016OHpWUU1zelVHOFB0ekRsMzY0b2FzV2FjRDRVbEhvYzI5?=
 =?utf-8?B?cHhwVVdvY3ZBU20zaDY0VmNiSFZVOVFobEVrNVVQZ3RLL0dZWmdwaTFOWHVw?=
 =?utf-8?B?V0hYN0tJOTIyTDh1YmFTdXZVamJadWpzKzh1WGJ4aHdNWllmZmtTVlF2T1FO?=
 =?utf-8?B?eGtCZVA5TzZwU3JNY3piaTloWUpBSmJFNVMydzRsQzQ4TUE5ZGRaU3JvdnJr?=
 =?utf-8?B?MUxrQjdTRHRWUnFKS3phZFVwY2pwVVFLWjNRS0JJSnlKL1ZXeDQ5TGFiakJs?=
 =?utf-8?B?SGpuS3hlcFBEODNJWFRiaGxVMkxQc3l3R1kvd0FEUURqVldYOXdnR0VpNjg3?=
 =?utf-8?B?THkvTkl6NmFUREhNdnYzVWpKWG9DaGZEWE41TDVRL0JIQmlaZ0hOZXlTQW9R?=
 =?utf-8?B?U1dwN2xLOWZqMnVCZ0xRUWFNWlBXeEg1dko1UVFWRmt4bWVEUEQxb3lrMHpw?=
 =?utf-8?B?NkJYRmp0YVpSVC9nbmFudDBuS0xnMHNyZ25BMGdvTGprZndYQ0JVS004TWYy?=
 =?utf-8?B?TUlma1Q1emIra3RFUTh2RVdhaFNYUGI4UGd2UWxUSUtCTjZzSk83NEZ6MHBt?=
 =?utf-8?B?ZGZNWTBlTGZmTGZjSUZ4eVVaQ1NWclkwWkZ6aHFPVVhzV2hRNWRGaXc0TFZS?=
 =?utf-8?B?QTVnZE8vQmZhbmo0RXNFRjV5VWRiTm5XdVYwd05YdExNNlEwUXFTRlV3dTdG?=
 =?utf-8?B?VS9IZS8zWThjNnNheHJlYkJBdkRGUCtIa0Uwd0pOMkpEZmRacmovVitwbGJm?=
 =?utf-8?B?M0RjWHZnNDNlU0Z0WWgyM3diVGxFWkppYnJZeXNvREtqcG90amp2YU1UL0hN?=
 =?utf-8?B?V0xMQ2duUGdCQ1QvazNxTHgzQWl1KzFLa2VKTkF0WURCek9ORTI5WmwwcTRx?=
 =?utf-8?B?Z01pZis0dXhNd21pVzZWR2cyTFFGT2UzYTFlendlekdBTno1TEJzV2N1S1ds?=
 =?utf-8?B?cHhwL0xFLzlXUFdLWVBlV0JMSzNjdnRuV3o2ZnJQaVR2SzA1WitITERMRSs4?=
 =?utf-8?B?ZWhxSUg5MTQ4d3Y5Wjh1ODJ6bEkvMTdYSmFDVWpoaGVoSnp3MVRIbVRDbm1M?=
 =?utf-8?B?VUE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0EB1C199B2CD964BAFAA2F2D4A93ED5C@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 3JyGyUzumRs8cVKnff0vGgZN12whA7zqjtCoLDQ9vxrE9LX78HQR/mamipkcP4Sh1i+iwwaD40HIaRGQjq+Sa0oDCHmPKD+88KyC2ibtF8yUXE/i7XISumnC99Kf5HCBDD/GU8trDAGmM7lrddOS47jIR5lv2Qs9Qx6PtyjJaBdFmaqFF3GM/AkfKkyDkm/wlJbAxUXdvkF0Vh9Ay/3VbszcS9IXO1D+m4vUbuFf00pr4n6K3S5RZlqZpb+rhQ2EDL/xJQ1oirlHS5fb5Uk6KBgPoGFH1SATSSoAVBZH9EdAf8iDvmiRqyVrNecSc5XEgOdz9Nw/L4R29J+uGUIQmzCGNYtsWMvL7qBD9qmSFql+26uUQgUiyylSGWf+C5sLOHO+ko5oqAnquC4dNq6Ux9REdUZEFCIF6kOoC+vsnIadPKpFcNNw5zd0f2dhPE/xF9Yrz5o/8xlvMtG3Rhc/aE4cztL3VWimcDTLahXjMFy4lzdUk47CnwQbZMESrZ4p42Zge5b6f9NJjA6A7L5WreLKg+NrIYmEvxzoTMqagfRB5eymtM0/096mb1bPpzg4MSVi1QmvkqAmGRTMAYazNxdQ0Gw5tKC/Z049LfkeaaeR0Wv/YZ6lo5G9L8PjP9i9t026KQjWkFRtdOHVwCXIun6LYwRrgexMXiyyZbkEfG4UJ1tBMHr0h5lJIO7485rShlQxd8HMBvyqdv5jlsHpsfb78oEhr4FvGkJ+0Pj7p/cCxflmxnqyot/GZhHFGZZcbFn86Un15fq8fkWUhKM8dDh+wRLs+N+fFse3lrEfPOWBpGilmmsrH8O2oc5dHN98kWscFKeG3WSEdqOE/omgkhuXrQSdJJyijZjrzufiTaMuVuF5GevBUeEboRDL3UGkX0jidFcaUXAiyOvcfqUDsQ==
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4791.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1eafa0cc-e8b7-4781-8bd5-08db1aa68f25
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Mar 2023 22:44:47.1240
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EBJJnG4YrKX7uwYfVVK1EMa/EWjNpA6uILM/TWhvtE4QmE93/4sZfb9HO+YYd+ZrJGPBsQK2Vu5QCzaB83goUA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4271
X-Proofpoint-GUID: z2oCX4-PkDUiOFkYhjrcXgXwwhJ6HvHm
X-Proofpoint-ORIG-GUID: z2oCX4-PkDUiOFkYhjrcXgXwwhJ6HvHm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-01_15,2023-03-01_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 lowpriorityscore=0 phishscore=0 suspectscore=0 priorityscore=1501
 mlxscore=0 clxscore=1015 malwarescore=0 adultscore=0 mlxlogscore=940
 impostorscore=0 bulkscore=0 spamscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2303010183
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCBGZWIgMjgsIDIwMjMsIFdlc2xleSBDaGVuZyB3cm90ZToNCj4gUHJldmlvdXNseSwg
dGhlcmUgd2FzIGEgMTAwdVMgZGVsYXkgaW5zZXJ0ZWQgYWZ0ZXIgaXNzdWluZyBhbiBlbmQgdHJh
bnNmZXINCj4gY29tbWFuZCBmb3Igc3BlY2lmaWMgY29udHJvbGxlciByZXZpc2lvbnMuICBUaGlz
IHdhcyBkdWUgdG8gdGhlIGZhY3QgdGhhdA0KPiB0aGVyZSB3YXMgYSBHVUNUTDIgYml0IGZpZWxk
IHdoaWNoIGVuYWJsZWQgc3luY2hyb25vdXMgY29tcGxldGlvbiBvZiB0aGUNCj4gZW5kIHRyYW5z
ZmVyIGNvbW1hbmQgb25jZSB0aGUgQ01EQUNUIGJpdCB3YXMgY2xlYXJlZCBpbiB0aGUgREVQQ01E
DQo+IHJlZ2lzdGVyLiAgU2luY2UgdGhpcyBiaXQgZG9lcyBub3QgZXhpc3QgZm9yIGFsbCBjb250
cm9sbGVyIHJldmlzaW9ucywgYWRkDQoNCkNhbiB3ZSBhbHNvIG5vdGUgaGVyZSB0aGF0IHdlIHJl
bHkgb24gRW5kIFRyYW5zZmVyIGNvbW1hbmQgY29tcGxldGlvbg0KaW50ZXJydXB0IG9uIG5ld2Vy
IHZlcnNpb25zLg0KDQo+IHRoZSBkZWxheSBiYWNrIGluLCBhbmQgaW5jcmVhc2UgdGhlIGR1cmF0
aW9uIHRvIDFtcyBmb3IgdGhlIGNvbnRyb2xsZXIgdG8NCj4gY29tcGxldGUgdGhlIGNvbW1hbmQu
DQo+IA0KPiBBbiBpc3N1ZSB3YXMgc2VlbiB3aGVyZSB0aGUgVVNCIHJlcXVlc3QgYnVmZmVyIHdh
cyB1bm1hcHBlZCB3aGlsZSB0aGUgRFdDMw0KPiBjb250cm9sbGVyIHdhcyBzdGlsbCBhY2Nlc3Np
bmcgdGhlIFRSQi4gIEhvd2V2ZXIsIGl0IHdhcyBjb25maXJtZWQgdGhhdCB0aGUNCj4gZW5kIHRy
YW5zZmVyIGNvbW1hbmQgd2FzIHN1Y2Nlc3NmdWxseSBzdWJtaXR0ZWQuIChubyBlbmQgdHJhbnNm
ZXIgdGltZW91dCkNCj4gSW4gc2l0dWF0aW9ucywgc3VjaCBhcyBkd2MzX2dhZGdldF9zb2Z0X2Rp
c2Nvbm5lY3QoKSBhbmQNCj4gX19kd2MzX2dhZGdldF9lcF9kaXNhYmxlKCksIHRoZSBkd2MzX3Jl
bW92ZV9yZXF1ZXN0KCkgaXMgdXRpbGl6ZWQsIHdoaWNoDQo+IHdpbGwgaXNzdWUgdGhlIGVuZCB0
cmFuc2ZlciBjb21tYW5kLCBhbmQgZm9sbG93IHVwIHdpdGgNCj4gZHdjM19nYWRnZXRfZ2l2ZWJh
Y2soKS4gIEF0IGxlYXN0IGZvciB0aGUgVVNCIGVwIGRpc2FibGUgcGF0aCwgaXQgaXMNCj4gcmVx
dWlyZWQgZm9yIGFueSBwZW5kaW5nIGFuZCBzdGFydGVkIHJlcXVlc3RzIHRvIGJlIGNvbXBsZXRl
ZCBhbmQgcmV0dXJuZWQNCj4gdG8gdGhlIGZ1bmN0aW9uIGRyaXZlciBpbiB0aGUgc2FtZSBjb250
ZXh0IG9mIHRoZSBkaXNhYmxlIGNhbGwuICBXaXRob3V0DQo+IHRoZSBHVUNUTDIgYml0LCBpdCBp
cyBub3QgZW5zdXJlZCB0aGF0IHRoZSBlbmQgdHJhbnNmZXIgaXMgY29tcGxldGVkIGJlZm9yZQ0K
PiB0aGUgYnVmZmVycyBhcmUgdW5tYXBwZWQuDQo+IA0KDQpJIHRoaW5rIHRoaXMgYWxzbyBuZWVk
cyBhIEZpeGVzIHRhZy4NCg0KRXZlcnl0aGluZyBlbHNlIGxvb2tzIGdvb2QgdG8gbWUuDQoNClRo
YW5rcywNClRoaW5oDQoNCj4gU2lnbmVkLW9mZi1ieTogV2VzbGV5IENoZW5nIDxxdWljX3djaGVu
Z0BxdWljaW5jLmNvbT4NCj4gLS0tDQo+IENoYW5ncyBpbiB2NDoNCj4gLSBVcGRhdGVkIERXQzMg
cmV2aXNpb24gY2hlY2sgbG9naWMgdG8gbG9vayBmb3IgIURXQzMgYmFzZWQgSVAgKGllIERXQzMy
IGFuZA0KPiBEV0MzMSB2YXJpYW50cykNCj4gLSBGaXhlZCBpbmNvcnJlY3QgZGVsYXkgcmVmZXJl
bmNlIGluIGNvbW1lbnRzDQo+IA0KPiBDaGFuZ2VzIGluIHYzOg0KPiAtIEZpeGVkIHN1YmplY3Qg
dGl0bGUgYW5kIG1vZGlmaWVkIGNvbW1pdCB0ZXh0IHRvIHJlZmVyZW5jZSB0aGUgbmV3IDFtcw0K
PiBkZWxheQ0KPiANCj4gQ2hhbmdlcyBpbiB2MjoNCj4gLSBJbmNyZWFzZSBkZWxheSB2YWx1ZSB0
byAxbXMNCj4gLSBNYWtlIHRoaXMgYXBwbGljYWJsZSB0byBEV0MzMiByZXZpc2lvbnMgYXMgd2Vs
bA0KPiANCj4gDQo+ICBkcml2ZXJzL3VzYi9kd2MzL2dhZGdldC5jIHwgMTQgKysrKysrKysrKyst
LS0NCj4gIDEgZmlsZSBjaGFuZ2VkLCAxMSBpbnNlcnRpb25zKCspLCAzIGRlbGV0aW9ucygtKQ0K
PiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdXNiL2R3YzMvZ2FkZ2V0LmMgYi9kcml2ZXJzL3Vz
Yi9kd2MzL2dhZGdldC5jDQo+IGluZGV4IDNjNjNmYTk3YTY4MC4uY2Y1YjRmNDljM2VkIDEwMDY0
NA0KPiAtLS0gYS9kcml2ZXJzL3VzYi9kd2MzL2dhZGdldC5jDQo+ICsrKyBiL2RyaXZlcnMvdXNi
L2R3YzMvZ2FkZ2V0LmMNCj4gQEAgLTE2OTksNiArMTY5OSw3IEBAIHN0YXRpYyBpbnQgX19kd2Mz
X2dhZGdldF9nZXRfZnJhbWUoc3RydWN0IGR3YzMgKmR3YykNCj4gICAqLw0KPiAgc3RhdGljIGlu
dCBfX2R3YzNfc3RvcF9hY3RpdmVfdHJhbnNmZXIoc3RydWN0IGR3YzNfZXAgKmRlcCwgYm9vbCBm
b3JjZSwgYm9vbCBpbnRlcnJ1cHQpDQo+ICB7DQo+ICsJc3RydWN0IGR3YzMgKmR3YyA9IGRlcC0+
ZHdjOw0KPiAgCXN0cnVjdCBkd2MzX2dhZGdldF9lcF9jbWRfcGFyYW1zIHBhcmFtczsNCj4gIAl1
MzIgY21kOw0KPiAgCWludCByZXQ7DQo+IEBAIC0xNzIyLDEwICsxNzIzLDEzIEBAIHN0YXRpYyBp
bnQgX19kd2MzX3N0b3BfYWN0aXZlX3RyYW5zZmVyKHN0cnVjdCBkd2MzX2VwICpkZXAsIGJvb2wg
Zm9yY2UsIGJvb2wgaW50DQo+ICAJV0FSTl9PTl9PTkNFKHJldCk7DQo+ICAJZGVwLT5yZXNvdXJj
ZV9pbmRleCA9IDA7DQo+ICANCj4gLQlpZiAoIWludGVycnVwdCkNCj4gKwlpZiAoIWludGVycnVw
dCkgew0KPiArCQlpZiAoIURXQzNfSVBfSVMoRFdDMykgfHwgRFdDM19WRVJfSVNfUFJJT1IoRFdD
MywgMzEwQSkpDQo+ICsJCQltZGVsYXkoMSk7DQo+ICAJCWRlcC0+ZmxhZ3MgPSB+RFdDM19FUF9U
UkFOU0ZFUl9TVEFSVEVEOw0KPiAtCWVsc2UgaWYgKCFyZXQpDQo+ICsJfSBlbHNlIGlmICghcmV0
KSB7DQo+ICAJCWRlcC0+ZmxhZ3MgfD0gRFdDM19FUF9FTkRfVFJBTlNGRVJfUEVORElORzsNCj4g
Kwl9DQo+ICANCj4gIAlkZXAtPmZsYWdzICY9IH5EV0MzX0VQX0RFTEFZX1NUT1A7DQo+ICAJcmV0
dXJuIHJldDsNCj4gQEAgLTM3NzQsNyArMzc3OCwxMSBAQCB2b2lkIGR3YzNfc3RvcF9hY3RpdmVf
dHJhbnNmZXIoc3RydWN0IGR3YzNfZXAgKmRlcCwgYm9vbCBmb3JjZSwNCj4gIAkgKiBlbmFibGVk
LCB0aGUgRW5kVHJhbnNmZXIgY29tbWFuZCB3aWxsIGhhdmUgY29tcGxldGVkIHVwb24NCj4gIAkg
KiByZXR1cm5pbmcgZnJvbSB0aGlzIGZ1bmN0aW9uLg0KPiAgCSAqDQo+IC0JICogVGhpcyBtb2Rl
IGlzIE5PVCBhdmFpbGFibGUgb24gdGhlIERXQ191c2IzMSBJUC4NCj4gKwkgKiBUaGlzIG1vZGUg
aXMgTk9UIGF2YWlsYWJsZSBvbiB0aGUgRFdDX3VzYjMxIElQLiAgSW4gdGhpcw0KPiArCSAqIGNh
c2UsIGlmIHRoZSBJT0MgYml0IGlzIG5vdCBzZXQsIHRoZW4gZGVsYXkgYnkgMW1zDQo+ICsJICog
YWZ0ZXIgaXNzdWluZyB0aGUgRW5kVHJhbnNmZXIgY29tbWFuZC4gIFRoaXMgYWxsb3dzIGZvciB0
aGUNCj4gKwkgKiBjb250cm9sbGVyIHRvIGhhbmRsZSB0aGUgY29tbWFuZCBjb21wbGV0ZWx5IGJl
Zm9yZSBEV0MzDQo+ICsJICogcmVtb3ZlIHJlcXVlc3RzIGF0dGVtcHRzIHRvIHVubWFwIFVTQiBy
ZXF1ZXN0IGJ1ZmZlcnMuDQo+ICAJICovDQo+ICANCj4gIAlfX2R3YzNfc3RvcF9hY3RpdmVfdHJh
bnNmZXIoZGVwLCBmb3JjZSwgaW50ZXJydXB0KTs=
