Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFAEA6C84F7
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 19:30:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230190AbjCXSaV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 14:30:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbjCXSaS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 14:30:18 -0400
Received: from mx0a-00230701.pphosted.com (mx0a-00230701.pphosted.com [148.163.156.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D05B37DB2;
        Fri, 24 Mar 2023 11:30:17 -0700 (PDT)
Received: from pps.filterd (m0297266.ppops.net [127.0.0.1])
        by mx0a-00230701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32OD7s7f021295;
        Fri, 24 Mar 2023 11:30:12 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=pfptdkimsnps;
 bh=eSZ7B1gGIQMeLucp/znIzwlcU3yb05kVCtFmpTAeTYk=;
 b=p/93yga2fPJtMzXqM5Fn/ze2XUp+IQQ/8HUfxfBBMNhyxUtecSo8U1ZyOTNDF0BdAlL1
 qiV6xsGxJH0UmUuccwxMS+xeIbyPzuqItag/b7w5XzJrFrntQzdAHSuE8ZhLbrlodUPb
 lxqaHl+Q6azoLSOJfpk7y118mvTcY1wISwQ6qOjq09JpuwZT7lc6Lv7KUG46Xqp9peFm
 U0SymfbQvdsJjFHH0LlMdLhpIaE6YU87das8z6sn9REo9eev9icNotmUQODUikJWotlY
 N3EX8GtsBaBebTtjCeAxLQqBPJFpat1lwVPb6Woc2jKT0GQ/IQOT1NCx98vngUxCgrLP fA== 
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.73.133])
        by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 3pgxkcw855-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 24 Mar 2023 11:30:12 -0700
Received: from mailhost.synopsys.com (badc-mailhost1.synopsys.com [10.192.0.17])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id B99C240105;
        Fri, 24 Mar 2023 18:30:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1679682611; bh=eSZ7B1gGIQMeLucp/znIzwlcU3yb05kVCtFmpTAeTYk=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=QybbLKutB762RIjZRr5HBUWVGz+2ZqLunUV8g1xPFr9NpCA+x3sgE239dPz8XsE4y
         u03uxzcBMZiAM/jPR1lXjw1LfIpO+SPMZEcql0bzQisOm7812549AjH3bUbNtnKWOR
         uD5kjxRJskcGZBIlZ+0p92SEiIC5hvx9+JeBSoIzyZVC2yNnaesf10VcBjqZV1QHKn
         hsEvyeMv+1r/XJEj4aaXYdbq6/j4Cu2worP52ROG28qvaof/oIuvsRIuXHXfZjWS5G
         SkXmVFfkaz+EfRrNatetEomtM5mABhXYwDgP9lD1wnH/9vvs8r0w0LoABTXbmEJ4Zk
         g1jP5aPJqueGw==
Received: from o365relay-in.synopsys.com (sv2-o365relay1.synopsys.com [10.202.1.137])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
        by mailhost.synopsys.com (Postfix) with ESMTPS id 62B01A00B4;
        Fri, 24 Mar 2023 18:30:10 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2109.outbound.protection.outlook.com [104.47.55.109])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id E224F4006C;
        Fri, 24 Mar 2023 18:30:09 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=thinhn@synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.b="Tq/TwJjd";
        dkim-atps=neutral
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bi6xyAedaCqQNa0+nwQQF0W0x/g5TMDC4pIxVLUR2Epq7mCp6w4Df+iOhZm6mDysNJSKEQ8up44qQ492MsCIwtYUiVkbjLAlO/xq0drp1Ppy95pOkI764BSjvkZZ+yQiJzJGX05hKSog6OOmQamp2c0oVWaHiwYe9+zpNaYi59qKCgfnoGAILjbaPzfdbGS6DwKk0S1cQqvQY7lb5c3Uq1Kl5iJHCmoKPXZnC5SIrzRfJLTJg4IcMLrkNMIevZIUsMvgOOrMWLa2nrKm5fmnjivo6RZS08mLd/RkYlC9X4TfjZctXYi/gHF0EYWR7UV2Lmni6nkZAJ/K6QWePhp76A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eSZ7B1gGIQMeLucp/znIzwlcU3yb05kVCtFmpTAeTYk=;
 b=FGy1h5no8vZijuD1yDp8exemusGXPe/cSgBCfMR+2PCQLCzSltbQYDyKj1bbrOZSqaLl3vNNydWke9nS+KoYUP/4xIDQgCCsV9rV4BrAxRTyoJGqX2ZZzaFiV7S1x2LRZ/0Gt/CF+djqBkQFVjLfLBSa9c9awoCB6cikOPFzxOgPADeBh9EdfQxyTNqph9EIr37MXc/LNyA4IszHffIwND6RQVwBzk9Hp1k3FXNAUqapbO7x1Ot5RKPjs9p/XtJ4dH6klejdOHUGTvnfZL9pPW5Orwsn1Qa+xf/EqDUxPy2r+0VbZ8Yj8mHGqqr8YMRSv1Md9tSz6r2WZuNi06ldNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eSZ7B1gGIQMeLucp/znIzwlcU3yb05kVCtFmpTAeTYk=;
 b=Tq/TwJjdxomulynkUK/tZq8EhBzPqHkgdTj55PHqw6s6IGXSj5O6n1gsUdW4L5XCWqHjgZEeUiLaaXLAf9Mno07iaCG/m5SXPFO0oBA59HAs56DIoAIvnUkjqcpsd3+EIf5MkRGLYN4yI4kOdrVUF8XK2/TT++8iO77smx/f8+Q=
Received: from BYAPR12MB4791.namprd12.prod.outlook.com (2603:10b6:a03:10a::12)
 by BN9PR12MB5382.namprd12.prod.outlook.com (2603:10b6:408:103::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.38; Fri, 24 Mar
 2023 18:30:07 +0000
Received: from BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::3161:c44d:8bb3:423f]) by BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::3161:c44d:8bb3:423f%3]) with mapi id 15.20.6178.038; Fri, 24 Mar 2023
 18:30:07 +0000
X-SNPS-Relay: synopsys.com
From:   Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To:     Mingxuan Xiang <mx_xiang@hust.edu.cn>
CC:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "hust-os-kernel-patches@googlegroups.com" 
        <hust-os-kernel-patches@googlegroups.com>,
        Dongliang Mu <dzm91@hust.edu.cn>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3] usb: dwc3: host: remove dead code in
 dwc3_host_get_irq()
Thread-Topic: [PATCH v3] usb: dwc3: host: remove dead code in
 dwc3_host_get_irq()
Thread-Index: AQHZXhduKUNznJm/vkS9ch2fLvfrwq8KQR4A
Date:   Fri, 24 Mar 2023 18:30:06 +0000
Message-ID: <20230324183004.3o7twv46duc2oufe@synopsys.com>
References: <20230324060934.1686859-1-mx_xiang@hust.edu.cn>
In-Reply-To: <20230324060934.1686859-1-mx_xiang@hust.edu.cn>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR12MB4791:EE_|BN9PR12MB5382:EE_
x-ms-office365-filtering-correlation-id: 3dcb8669-5768-47af-fe43-08db2c95cad3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: BbOuldnGjORLofm/h8y8xgW2CCI1YpLPYa4YN6GcIc2hZmSQuKqvd/7EeMI9fUva/rQPZlE4QpX5Ak0gy0ZPsN5utknFrt4OWFuIogDXlsDKb4F11JNvoXg+V9AjpX0tmbBJGU9GBhu6IvICCTAcAwPK5fuJTJq96zQmvoz/Ob3hgxDKWJFwDgnxy4Q8ekFT13cXd3v5KhAKXF/TYNwXSUK3lTxO+7n6npYdmdHR0TNBZaQgdUTZO0xQ68xpi2gx8AL5+CA0BSKFXrikQs5lfb6bOAs9zuKX8gfr5uGvhC4sj13Aw7zzcCIxar2Ydg8OkLVssKpTTxcWV8jkBd0sX+52dNaKBjcj7EM0c9P4akc6102USQuIF9ScqJwrL+DLvdDPyb7ZwJct544DCHuD05r2/Rgb+nXzW2Wf+nr+XBA3pcbHke0WZew304fOfxmXYVWMtlxMMBXdVVRbBI8EXULyPIz791X1UOYRGAbO9eCyUpDiAkO6bbhiJp83u6fr7VoAH9/1PJp+eY3Sc2QqdDIVtInpwrJRiEAcGWq6M9Iij3pkM97g+dlj10JyuJd92h+XgUsFo2bYTQ66mW4WeG6NCkieSRxBKRiw4rogelEspKZfKwmHcJNHnV21Gw74btkpDuxQUEvT/++xs+9BvXFJ787EDa8ySp+libHC5pGaZ/+PQRO5vJOiSE/FVe9doRJA8lVkOAzIpEveEx54zQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4791.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(366004)(376002)(396003)(346002)(39860400002)(451199021)(38070700005)(6506007)(1076003)(26005)(8936002)(6486002)(6512007)(71200400001)(66446008)(316002)(2616005)(186003)(478600001)(86362001)(36756003)(8676002)(66556008)(38100700002)(66476007)(6916009)(64756008)(4326008)(2906002)(41300700001)(5660300002)(122000001)(66946007)(76116006)(83380400001)(54906003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MGVRRW1iTU5VMmROT1FhcEJMK0RZOHppSEVBWTBLRGV6RzR5Wi84RVhhZ2w5?=
 =?utf-8?B?S2l2eXBGRnR6OG5pWHFjZ0pQbUM5MmZjUEx3RUlsdVhNWVYrTUIySUlRUjA4?=
 =?utf-8?B?OUN3bHdFUVJFTEZMU3FqL0JON3JKWkp0NG1ySWhXU25HTTQvZzQ2TUhVb084?=
 =?utf-8?B?dWx4VWpidC9KMFFzU21VMnQ3Q3d5M095YWw5UE1DZmNCVHVkdjRIWjdqaVZi?=
 =?utf-8?B?ZWdMOGVySzFVa29Xa25lUlZ3K01SQTRtMFl5WkRBSjZVNndoM1c2dThSRVNV?=
 =?utf-8?B?aDVRQUYwRnhYK2M4b1NVbDEyOVllTTNNck83T09SMTdLbzdNRmFoVTdHOHUy?=
 =?utf-8?B?bVFZS0d1RG9HZVlJVVBZQ3BSazZvZkJFekNGUHpIbGR5VXZLa05KcS9nU0xi?=
 =?utf-8?B?L3Y3MThOb0Q5NFdxbG5YcU1vekxtSXBjQXRFVisyNWR5S2svZndqOVlUVi9I?=
 =?utf-8?B?azZCZVM5cGlydC9NVEZJdm05YlFlaTFoVmllVjFpOGI2OUpkWXBVVENJSU02?=
 =?utf-8?B?TmhWbXZQWTRoODc0WVBvNVhVbDFwVERnbHRRaHA5OTFRdkV1NTJhYnMyZTcx?=
 =?utf-8?B?ajZHYXBCNEZQVHZmbnc4NGVNYkxYTDJNU3VncU5PWm5lRHd1NmVBYlgxdXV2?=
 =?utf-8?B?SGN2TVlLaWMwNTU2THpmbGxMNWNqTkR2SzB6M0x3SGp4RTcvTTl0WjltbEp6?=
 =?utf-8?B?N2owQ0NaOGdaUVFhYy94Z0Q5YXMveVU3RjVSNnBxK0h3NlhpWUE3Y25GOWV3?=
 =?utf-8?B?ckpGa1J4QXJTQ0NQZy9HdFpZczdFWFB4SjBNbmdUbUMzTDVUclc0Slp2T2JG?=
 =?utf-8?B?dGJhQmFVaCtHQjFlczBxa0JzT1hRc3hRcExUTlFuMVZVSW1JT1BLdnJoT2o5?=
 =?utf-8?B?ZnJrSkdXdFRnRUJEY1ZQdDdCTEtXMzZ6ZENpM2E5UUpndmdiS3Rvanl0Z1ZW?=
 =?utf-8?B?bE5IRXhYSnp2aDNjRDRBb0Zjd09obTg3M05McVEyTUE1V3J1dVBCQ1YyTEEv?=
 =?utf-8?B?N0N0NkFhL3pLN2h1Ym44dExITFZnZU5BU3VaTm9neGdqUUlzNjJoTnY1Ky9O?=
 =?utf-8?B?VzRwUkxudFd0OVR0cE1vN3Faa1c2bmJpR1FIRnFXMGpMOFhCRkdTY1ZxKzRL?=
 =?utf-8?B?R2hXUHd1SGdFVzJLOHN5aE8zVXU4K1ZLM2c4TU91YXRzbHBmbWdOSXpNQ243?=
 =?utf-8?B?WS9QOS9XN1BYSnBBa01GY21KOS94UkMwVDltQnphUkhYWjNCREhCU3lhbGFE?=
 =?utf-8?B?MU11UE1TUEZ3dDV3aGU4ZDVBNE1XNnBXTHNmVmdnQmg3d3RoaDdtOUQxYy8w?=
 =?utf-8?B?cW9DU24zd3VWTjZXUjRDRWJWY2liakM2SSt2cm9PN2pMSHYvT2xhUkcvVFZi?=
 =?utf-8?B?S1dQckkvWFhHSVNMZHc3V2twRmVsRDk4SGpRblY3cFI1UlE0STZrZXNKWnRG?=
 =?utf-8?B?dHFSWGlNU2RGNHo3MURwWFVmaW9uUWszUGdFamRsRmwvYVBvQkl2R2NKbjVx?=
 =?utf-8?B?MTcrUml6OGp4bm5WMUNDMmJydlRwVmZvU05sYkM3MGRwbko0aTJLOW5wUkFy?=
 =?utf-8?B?cmlpcWRzTG1hU0hPUWdMMk8vdkxXOUh1UXN0QlBHcTljK1h1TythRVZKOGs4?=
 =?utf-8?B?OGQ2NkVxMU5SazVYdy90bFFWaXJvdndqYUllbHg1MlJ0TnA3Rmh1VzMvY2RY?=
 =?utf-8?B?MndhTno0aHVJWi9VSnhaelBDb25EK2FKaFVwR1ZpbFN5OWVVNGIyNlZmTnZ3?=
 =?utf-8?B?VFVMWlMzSjI0VDJyQkpOOHgyZVBFSHNtSVJ3ZVY1dU9DRTBVWlFpNnBVTlVB?=
 =?utf-8?B?NHBSSEkzTDkzc3NIUzd3bEpHTFl4bG5SanZ5TUc3RW5ySy8yM0xZelNBZlRQ?=
 =?utf-8?B?UXBIL24wVldST3pyMHYwZ3pQZ2c3dEhoSXcyK3JFSWNKMktyR05FelZFdGY0?=
 =?utf-8?B?eWtxeSsyekdTNFk2STJ6eHpPaXpqQUF6VjFLKzF4MmoxZjlDVDBsM0VIUXUy?=
 =?utf-8?B?Mm5HazFsOXlnUEdFMk12RmdDa2hOenVHdUNDM3FJNTUxT2MwWlRlaHBWbXMr?=
 =?utf-8?B?MzJjNmZLWHpxcU03VitSL0RVUktldkxaM3Z2aE5tRWdMcEdBTUJmbWNuaGpQ?=
 =?utf-8?Q?K8Z5E8Cg6L2zGxly5+jW9HmyU?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <05518F55F9FB7B4895325B5E73888B01@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?VFI5QVZSM0lFOG95Mi80dWk5dDYyckllZ0RDcU9kRXh5c2taZ3lRcERVd2tV?=
 =?utf-8?B?VTZIdnBnbkNhaHpMM2VzcmJMOEdVdUFSZWVKTTFtMkVyWGJ5Mjc4K2ViUzFY?=
 =?utf-8?B?eVJVT0JJM2hSSUV6bVFpaWJaSXFJcXVZT1VUdFc0WWNqSENYUUtnZHNDUU9y?=
 =?utf-8?B?NVZERTgwVDJoTStzdVUrcEJlMldJbjFzS1cwMTdXRE50UlNra0JmKzNzV2Rs?=
 =?utf-8?B?MHgwK0lhVVJ2blFvR2lYc2Qvbld1eWprNGRST21RT2FaWmluMkdmWUtLanBo?=
 =?utf-8?B?YVBCU2NFSUtMYVZibUxGMkZETDRHdXJnVFRzemZ1VE5FWWtremdiSktaR3Yv?=
 =?utf-8?B?R3dpajNlMlcyaHJPZ1RORkFtRVZucEtIRlpHT2JKTjdXVGhnOGY4cFlZcXdt?=
 =?utf-8?B?aXYvcWxrZzJiUG9jN3JxU205M0p0NzdOd0h6NjZSU1kyTjJiSkllQnF0cjYr?=
 =?utf-8?B?NVFFbzFYZmd4WFphZitjVEtZZmNIV3BvdndLZXIwN1FJYmVSdmozRlQ0WXhY?=
 =?utf-8?B?NWw3T3JFb2tCc000NDNWL2hTeUFFU1BxTHdJT1ovNVI2bDAxRVBkYzhKd1R4?=
 =?utf-8?B?VTdCb1pMTHNpZnA0WmJmQWlMWHlJMjMySUhVdUIveWNSakdKcmxhcGNhRXVB?=
 =?utf-8?B?dUVIZjEyMjZqMms5dEF5TzFTdnBhN0NHL3BsaEV2MXBDVHZYNFltWUVHR2dC?=
 =?utf-8?B?bU9kWWFXV0V1NGxLcGIrZXBoVGxidlJnb3kxdjM5ZXRhNGdXMVJBaUM1RnNN?=
 =?utf-8?B?Qkh4RUlKQlo2cERhTEtRNlV0VTgwZ0FrV3RuOWN4NUUwZDdSRXdEcndnbHVu?=
 =?utf-8?B?TEFxN1NVcnJTSTQ0VzhsMWk5ZFBDZkgrZEZURG5xVGFETU1XazhYL1FjYU16?=
 =?utf-8?B?aWdLQXd6dG1OYVcvcG51WU5adGx2WVlPTmJveERqYWNxQldoYWFUbVh4Q1Fk?=
 =?utf-8?B?Q0o2THl6RUxpNXg3M2dGdjdleXBQR1FLQ1hQYVFRM0QycUE2N3pkV2Y5bG5O?=
 =?utf-8?B?aXVienNFcUtheEQ0eVF3cmhsNmhITkNkdGxRNmFHNUNjZllCMUY5MVFia1k5?=
 =?utf-8?B?bTh5YjJDRG9QUW9tZHZHU0YxOG4vVnNRaWFqOXNNQVVQOCsxeTF2ZCtETkFN?=
 =?utf-8?B?dmM4eDl2SnJrd1NZa3ptZlg0eUM0SE95MjM2ZmN4SVY2bTJZMkRZeDRJUVc1?=
 =?utf-8?B?VlVWVjdObUpQVjZLQ1JCcld5bkVxR2lLWktKLzNZL3JFZEF6K2o1ck9WbTRk?=
 =?utf-8?Q?Ng3P2dgvIf9vk9+?=
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4791.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3dcb8669-5768-47af-fe43-08db2c95cad3
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Mar 2023 18:30:06.7384
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dijAQY5hnziT+YCmDTTAex+dj4PUhKQDELTCimp+s0GheB915yW0jCQi0TnPKowx3MZtc0amX7+FHr3ZsJvSww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5382
X-Proofpoint-GUID: inTVHcKmkfip4GgWTsesFPN5VT-C5EyZ
X-Proofpoint-ORIG-GUID: inTVHcKmkfip4GgWTsesFPN5VT-C5EyZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-24_11,2023-03-24_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 mlxscore=0 suspectscore=0 impostorscore=0 bulkscore=0 malwarescore=0
 spamscore=0 adultscore=0 clxscore=1011 priorityscore=1501 mlxlogscore=999
 lowpriorityscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2303200000 definitions=main-2303240145
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gRnJpLCBNYXIgMjQsIDIwMjMsIE1pbmd4dWFuIFhpYW5nIHdyb3RlOg0KPiBBY2NvcmRpbmcg
dG8gdGhlIGRlc2NyaXB0aW9uIG9mIHBsYXRmb3JtX2dldF9pcnEoKQ0KPiAgKiBSZXR1cm46IG5v
bi16ZXJvIElSUSBudW1iZXIgb24gc3VjY2VzcywgDQo+ICAJCQluZWdhdGl2ZSBlcnJvciBudW1i
ZXIgb24gZmFpbHVyZS4NCj4gYW5kIHRoZSBjb2RlLCBwbGF0Zm9ybV9nZXRfaXJxKCkgd2lsbCBy
ZXR1cm4gLUVJTlZBTA0KPiBpbnN0ZWFkIG9mIElSUTAuDQo+IA0KPiBTbyBwbGF0Zm9ybV9nZXRf
aXJxKCkgbm8gbG9uZ2VyIHJldHVybnMgMCwgdGhlcmUgaXMgbm8NCj4gbmVlZCB0byBjaGVjayB3
aGV0aGVyIHRoZSByZXR1cm4gdmFsdWUgaXMgMC4NCj4gDQo+IEZvdW5kIGJ5IFNtYXRjaDoNCj4g
ZHJpdmVycy91c2IvZHdjMy9ob3N0LmM6NjAgZHdjM19ob3N0X2dldF9pcnEoKSANCj4gCXdhcm46
IHBsYXRmb3JtX2dldF9pcnEoKSBkb2VzIG5vdCByZXR1cm4gemVybw0KPiANCj4gU2lnbmVkLW9m
Zi1ieTogTWluZ3h1YW4gWGlhbmcgPG14X3hpYW5nQGh1c3QuZWR1LmNuPg0KPiAtLS0NCj4gdjIt
PnYzOiByZW1vdmUgY3VybHkgYnJhY2VzDQo+IHYxLT52MjogcmVtb3ZlIHJlZHVuZGFudCBnb3Rv
DQo+IE9ubHkgY29tcGlsZSB0ZXN0ZWQuDQo+IC0tLQ0KPiAgZHJpdmVycy91c2IvZHdjMy9ob3N0
LmMgfCA3ICstLS0tLS0NCj4gIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgNiBkZWxl
dGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3VzYi9kd2MzL2hvc3QuYyBiL2Ry
aXZlcnMvdXNiL2R3YzMvaG9zdC5jDQo+IGluZGV4IGY2ZjEzZTdmMWJhMS4uNjFmNTdmZTViYjc4
IDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL3VzYi9kd2MzL2hvc3QuYw0KPiArKysgYi9kcml2ZXJz
L3VzYi9kd2MzL2hvc3QuYw0KPiBAQCAtNTIsMTMgKzUyLDggQEAgc3RhdGljIGludCBkd2MzX2hv
c3RfZ2V0X2lycShzdHJ1Y3QgZHdjMyAqZHdjKQ0KPiAgCQlnb3RvIG91dDsNCj4gIA0KPiAgCWly
cSA9IHBsYXRmb3JtX2dldF9pcnEoZHdjM19wZGV2LCAwKTsNCj4gLQlpZiAoaXJxID4gMCkgew0K
PiArCWlmIChpcnEgPiAwKQ0KPiAgCQlkd2MzX2hvc3RfZmlsbF94aGNpX2lycV9yZXMoZHdjLCBp
cnEsIE5VTEwpOw0KPiAtCQlnb3RvIG91dDsNCj4gLQl9DQo+IC0NCj4gLQlpZiAoIWlycSkNCj4g
LQkJaXJxID0gLUVJTlZBTDsNCj4gIA0KPiAgb3V0Og0KPiAgCXJldHVybiBpcnE7DQo+IC0tIA0K
PiAyLjM5LjINCj4gDQoNCkFja2VkLWJ5OiBUaGluaCBOZ3V5ZW4gPFRoaW5oLk5ndXllbkBzeW5v
cHN5cy5jb20+DQoNClRoYW5rcywNClRoaW5o
