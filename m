Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 302EC6FE8C1
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 02:35:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236036AbjEKAfc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 20:35:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230023AbjEKAf3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 20:35:29 -0400
Received: from mx0b-00230701.pphosted.com (mx0b-00230701.pphosted.com [148.163.158.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5999759C0;
        Wed, 10 May 2023 17:35:27 -0700 (PDT)
Received: from pps.filterd (m0098572.ppops.net [127.0.0.1])
        by mx0b-00230701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34B0J1UP029098;
        Wed, 10 May 2023 17:35:21 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=pfptdkimsnps;
 bh=2RYpZRvqkucVbGaUk1uHYAnUUdWdwv5n26O7Nyj9tZU=;
 b=oiPq2z5Meo9nCV36+Mce/wiceR7ZV4wOFfIykSzhRJOIfZx6SoNfOPI4Jx42omQkpUaz
 38vOom7HJu4tmEnfEAw37CsXuDNLjhkYUGWrgk+QEqXmTW1G+MMMFTM4misOUfXtv4tC
 qcw8IRwjymnB5WTdFdW75pA2NxH9kXZCIp0gz3nWvg+vKUQY9yCKsthxWJelRGNTowzv
 fdsq+qX9QJiIfiSM+7ZvEP/CcD4EmcO1LvRP8FiOJfZXubIJ/AASW62Bo1J7oFnd/H7h
 +8X9t3JgWHN9c98+CmWXMZ8TDXrWPBHOHPGEqBE9C0ks+iAxhVff4fpFzT7UnyqjURIq jA== 
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.73.133])
        by mx0b-00230701.pphosted.com (PPS) with ESMTPS id 3qf77umpg3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 10 May 2023 17:35:20 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1683765319; bh=2RYpZRvqkucVbGaUk1uHYAnUUdWdwv5n26O7Nyj9tZU=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=CrgXu15Ufl0sRLYxsMNfsWodhPG/ErqVPhsjdLik1s9YZISdnrnNF4qpKHjcRRz3d
         whzKtOl3FLSkmODlp4ERw3kmaNlqv4YDHVmEkdM69BMknWYI6jY6zULvvl8Mx2r2Sa
         l12DY24iaNmgWfodwWsVakafHOpTmGIGTJ0vaYIH225WzN7l2JLFam8TvCLj8nR0W6
         oL3hSN4Hlcm1mjB1BhJ+vDCy0pMeFXRkaeo+vDiBcBSxNYcF5bBgoVhLVS6iW9jiJC
         lpw/+RQXdzGNtdgGupSITRQ7YCqwHB0lmcEQUa41b0vFEmcbQv6Xzk1awQqQzfjNRE
         KQRkK+EyxNoTA==
Received: from mailhost.synopsys.com (us03-mailhost2.synopsys.com [10.4.17.18])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits)
         client-signature RSA-PSS (2048 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id A5EE440522;
        Thu, 11 May 2023 00:35:19 +0000 (UTC)
Received: from o365relay-in.synopsys.com (sv2-o365relay1.synopsys.com [10.202.1.137])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
        by mailhost.synopsys.com (Postfix) with ESMTPS id E17D4A0081;
        Thu, 11 May 2023 00:35:17 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=sWh93bim;
        dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2104.outbound.protection.outlook.com [104.47.70.104])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id 2DB314060B;
        Thu, 11 May 2023 00:35:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Rq0LTX50sDxgV7xoJdzM9hXqRMjO+TWKseAV+7Y88BV56NC7ppThKbsD7XWzDD6U3lp4wvQ4nGHYcYuLzjb0t+WQzTOgVlA8o+FbeCizFCknaEHsXmjBvgNSTNT6wdz58JU1Y86kV5CREZPU54lSHLr6dFW4bybEZ00CYNjuyMmWTc/Ya2JvnbPGaK4385oOWXAzZSZ4dvE8Yl6LOXcs2n3i+59nuZbXPUcOquFdoj2Lnr/K8KDMn2GIOvcJ45Q000ceFFoh7g3CK3TyIxfBVdAlJM8SdGlL4oT76n4yyMD7lUjUSyVcuo6yHViNXyG3hH2KepoAdKew0i10rii1CA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2RYpZRvqkucVbGaUk1uHYAnUUdWdwv5n26O7Nyj9tZU=;
 b=nH+t1kjU36VrBnQRXC0g2z+GI2Q13/L5PLb+r2FWgYup+ltS/kL/b5qcSJY9IsOdDiGSfHVXrL10yMwV1tKU8SSs0R6fFoHNg5jmNoL6rZZEQZ9aME8TxeUg5qd84D8/jR98uk0OPaxNybEfQYChfcOMfHlinR4gn5aLefphWBF1QJVcre58sztEy9f5/mSq8NjcBOY7KSfZJZ5oE2uuTjUrhoHrttfiF3gkkPnYUDNEwOkZPEr7eFaQB7K+i1cn2Ueud9ZKXM39iDVg7oVe/sbHuutB4PoJbMdK/WELFA27cjB/pBSGSH/HD1JoIqGC/eeRTb1FCtb810katNtWMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2RYpZRvqkucVbGaUk1uHYAnUUdWdwv5n26O7Nyj9tZU=;
 b=sWh93bimVDYU4yr3bH3Tho9LOeuj8YF6ZkktyCgcYkgmNbOeILXbEVNPmD/brE65FhR/3eKk+3lbOkSGg5txfdJ4MQgrZY8QU593hOSftuIFG3XLnqKI7wWN0EyR0y1gbp0msj4boso5NwciJhvu+LFUQ+srxfsEy/HCsjkUKFk=
Received: from BN8PR12MB4787.namprd12.prod.outlook.com (2603:10b6:408:a1::11)
 by BL0PR12MB4913.namprd12.prod.outlook.com (2603:10b6:208:1c7::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.33; Thu, 11 May
 2023 00:35:08 +0000
Received: from BN8PR12MB4787.namprd12.prod.outlook.com
 ([fe80::d13e:1438:9692:eba6]) by BN8PR12MB4787.namprd12.prod.outlook.com
 ([fe80::d13e:1438:9692:eba6%7]) with mapi id 15.20.6363.033; Thu, 11 May 2023
 00:35:08 +0000
X-SNPS-Relay: synopsys.com
From:   Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To:     Stanley Chang <stanley_chang@realtek.com>
CC:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v6] usb: dwc3: core: add support for realtek SoCs custom's
 global register start address
Thread-Topic: [PATCH v6] usb: dwc3: core: add support for realtek SoCs
 custom's global register start address
Thread-Index: AQHZfvx13m4Tu4feIUCbDoNY4rTDja9UQsAA
Date:   Thu, 11 May 2023 00:35:08 +0000
Message-ID: <20230511003436.k3advl65gtabu7rx@synopsys.com>
References: <20230505025104.18321-1-stanley_chang@realtek.com>
In-Reply-To: <20230505025104.18321-1-stanley_chang@realtek.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN8PR12MB4787:EE_|BL0PR12MB4913:EE_
x-ms-office365-filtering-correlation-id: 510a5ff3-bca3-4f4a-0a0a-08db51b79279
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: s1b1C9jdmvOejQuGYn9A1aAvLG9EVzozWfPw5QvKwFWNA+6ZWXtAHwr9qLzRCzhbovyBVKpf2BzThe2xHuIgLqxEb5n/qeUYdXaHkHsSABEs+y/MP3Nnnv3fuaUNv61Tw2r6FXHx8jsRRDKNLh5uCYsFP1HP3h+rdUxz/ZJ64tQDLNF6kd4uIKyAIhYLsJDzgF8rE6Xrl3MXTxWPHgdtjtKffN+uJoEA2du1EjKwGnwnQdI3bX6uHu34berYxGVugDxV49zKPelxFiEAeG7TI7EcH5Erp3FoOqwqWJGNxQnTWHhxVWu73gFxxlv8TiO5/pbCiiYqJG6a9bneIvCoerbN38YISOGlTxPfJA+Z0Apk7+/2eTwvaZ76mqBt1Y0ZEU+pnY3zyAussSSWPMCHc2VoQIV/QEowEEjXjZLBtbbSp8tddW4sj7m+vs8qffnwhBiM4gQaIBiS1OAxTsxTBaC7+VGCjnA4TBE0zEVxcdZHW9op5BCo4UyLC7ogsCnY5W4PF+lDyel2w78osjilZr0A3OBEd83313+OeXyuVBLy0Iextdbk5/oMK2wVrJHnoPKwQrV7+pE59LJZmgRqnLVR1YJhhfbyCm2NxDLWa6pVULaX4fCaUWG7oZ/iZjdy
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB4787.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(6029001)(396003)(39850400004)(366004)(136003)(376002)(346002)(451199021)(2616005)(478600001)(86362001)(6486002)(71200400001)(6506007)(6512007)(1076003)(26005)(122000001)(66946007)(316002)(91956017)(54906003)(76116006)(66446008)(66556008)(66476007)(4326008)(6916009)(64756008)(186003)(41300700001)(38100700002)(5660300002)(8936002)(8676002)(2906002)(38070700005)(36756003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cW9JaERvbWhxMUg4SFg0ZDdzTkRnWitCeTg4QWlxdmVsRGNBZWF2cjBIL1dH?=
 =?utf-8?B?aWhkeUxVV1VXWS9od0VmLy82aEVBWWNWc09qMjFUV1padlNtSU0vOFArNTcv?=
 =?utf-8?B?V2VvcE9pOFZKRzFZMGUwblRMVzhvaWErVC9IcnJUV1JOZTd3RVd0aHQ3SDBC?=
 =?utf-8?B?MlFaeG1zUENZZXVTZUplVWNSdi9CWTQ5UEFOUDhUYWpyN3Y2R0dndnNlakkz?=
 =?utf-8?B?Ui93a1d6OHFZUjhNTWJhQ0xQUThWUVc5SGpQRGlobUxjeVA2eEVmaXY5OHpM?=
 =?utf-8?B?aVFoVG9pUEJiMStGb1JvWkdLTXphL04yOWhZcnUzaWQ5enl0QmNnVEJITVpW?=
 =?utf-8?B?ekFTK1FjbmhLUHk0TmNQdHZTTHdpU1VTRmV6QzBqZFBzMFAvRTRPUlFVdXFB?=
 =?utf-8?B?dDNwbUV5OTdWVk1aczFsMTV5QlgvazQycVUvSXRRb0dEdU5WeGQxZUtXMXFG?=
 =?utf-8?B?VUFmK3ZjckFCbGI3eUVsVHhVNHJ6NlBTOGtKTWlHcjBIUWhsRVRTMDVDMExG?=
 =?utf-8?B?RkkrNHNmVXEzYzkzdjM0WDVpK1Vac0hSU1VxdGpsb0pTbXUrMTlHM0pRYzhl?=
 =?utf-8?B?NG4vMHBPRkVRVXh2S0UranRuOURUVmdKYUkwWDJHMG1KRWVZWFhnVWVSY3BW?=
 =?utf-8?B?YUFmQzYrZm1mZ3NSbEVrUjA2cGo3ZTE1aW4rYksxc3pDV3FEQUJBZ0E2Wm9G?=
 =?utf-8?B?bHVhQzJwVHhMMFI4WmUreE14SUI3RDdFTTFPbnAxcGdCa1V3VTIwOFFNeDhY?=
 =?utf-8?B?Z3dJSVJ0TmZyeFp2T21kVysyTXFZVjQ0akZWQ1NnOTUwbzJWTVNYRXJua3cv?=
 =?utf-8?B?dTFtWWtvMitGRWRWNGZ3aHRXQjhwbFhXeU5YMUxza295Y2d5eTNPYUFTTDVj?=
 =?utf-8?B?UFI1REtFTU1nK1QvM3N4SG5VdGZHSWVaNWQrTnF2d016M3FWQm1KSTNBeDZV?=
 =?utf-8?B?QTRsNlREL044aldZUnhpN0l3RFdxQ3pGZlM0SC84U0dON0J0UnVNSFk3TDFG?=
 =?utf-8?B?Rjg0WXgrOTY3aFVLN0k2ZVd4bnMxV0szUmlYbFlPSTIvOUFqd2s0QTJKL1c5?=
 =?utf-8?B?K2JCcUUvYUVBWmcvUTMvcWRzY3IwZk45ZGVhVWdLbjJMRklWaTk2QjZVMnR3?=
 =?utf-8?B?Nys2K2QwUDdFUytzUDZwMyt1c3lLRnZUSG5NVUFZSnZqaitMMmRtV1ltN2o5?=
 =?utf-8?B?YUd4R2RKN09pVS9hbXlPdlJwYXhaL0JFbVJzVHVOWHN6VENqOTNSb2kxek1X?=
 =?utf-8?B?WU1hamZUOVRhSHVML1hwV0l0NkRvZklDWmw3SndsaktvV0Uzc0tjN0k2RFNU?=
 =?utf-8?B?YXBmc21pVElvZEU1Rnl5OXU1R00xY0FJenBrWjZ5dncvVFJKVU5iUmtWTm9r?=
 =?utf-8?B?Tk13ME9RV1hqZVJMWHQ4SmZuRERjYmRLb2ZwMXU2N0xhOW5MUXN1aCt6UllK?=
 =?utf-8?B?blZxVW9pVXJxTTdYQjJBNzJmQ3hSYWNVc28xaWx4WHpVaU9TdU0zNkVUek9j?=
 =?utf-8?B?Y213amxxZ1BoRk0vMExTS3MzS0p1YllZcTdMUUFack4yVll5YVluT25lSlpC?=
 =?utf-8?B?allKT3hpbGx3ZWhHQ0RMcE94bkk0ZTRBdHBST0VWYWhickdzaVZiRzI5MHJt?=
 =?utf-8?B?ejR4eGFKQi83dXM1WHQxcmtWdlo1amVJOEJPd2d3QnZuWStzQmthVWR3TEtH?=
 =?utf-8?B?dE9EYmpQUGs2aTlPWVZabXdZdnVySmdkcUlXTEJtaVE0MFM1QXd6ZU1oQkc1?=
 =?utf-8?B?VFN1citabEtrODU1cUJrS0N6K0dWVkVIRkwyeXJ0VVdBMW45NG9jZ2tPSmZT?=
 =?utf-8?B?aUY0cTZuMGRDaTRlK3J2enBBdk8zMlhDRnpzSlRUUlIySGVXR0dneXd3WjNo?=
 =?utf-8?B?R0ZzU2tGZXV6cEVGOGpCSnNvaTIzWVNhMkEvWGtNY05hZlYrSWh2REplQ3gz?=
 =?utf-8?B?SEdpTENuQVptSGl3dUVSTVlRVGl1SnZIOUJaam9DaVp3WEJUUWtFNUxmVEJq?=
 =?utf-8?B?c3Q5OEZ5YXd3cWhFQjN5amwxQWdBaXllVEpQNXJuQ0I5MGVXd1RTTk5ieWpw?=
 =?utf-8?B?akFrZ2dwcjNoNHFQQ0NLbkdBSWM2SVFmeHg5Q0JQejJjRXhoQThGbmZnZXZ1?=
 =?utf-8?Q?Km2GSjGA2ofvoRs2enw/syL8a?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1DC7FD0CFAC8114EAF5E7A2E07B078BA@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: WX2ZTKZbHzsdnyUgyi6UqUMByB/s7AGwdPKlIM6+PwebvoXPWvKwaOpxVTXs/v+XVKUhl11y+30ZWbMmi+3oQrF7skyxKK1ymPRZrxwFMVudgfrZkNQjbKjbqSLT4IFvmh54l63c19rPBJQ6RqN8NFl0RhzmKHiMbQwy/k7oJsSwWm53/CynqcuHHFaJUU5D+4tAz/Z7BgTqT59LWsWUI/fOs05O0hZJLrzdaogXS+tqwpjehUzPMhWynDyeLRNqBz5bbYw6NA9W3UD3U26cTunmqM6p69BZqi6ou0R9osnd4erP5/PkCNp9qnjDafO5ghbR615PEmR/IgjHgCui7v9dyIwBvfnBPjkzIKpfoBuktsmzs4TQBCJVTqcZQWv5vczKuisrXIvFDMFRl2K3Rr6OAdVek+YUfVUPbW82bWInPNghHYdlqf0acK5SeNFzXN2EUN4/76eT8MwxrpzA1owyvd8ydBdoOsBrnF/Y4buGe+fQ0iimMsC86fsaJLZ7S8ciqW3+nE0dz+seVfb9k0/uiOO+owtkDYdvuzlY9yGYcDoY/qBpb08OoceEQCKevebbenE0kRiUpHrCOeDNH1U1xbgnPRhZg7A6HTrzUQu/OAkXBvJDMTvHIsnM2qwx+NC+GdgR3BuDbduq6dOpmTqOvdI9eU8uf0M6C1rJ+ayrSoU1qvLt58aZyDL0eRIy9rfYgvs91Q5MRi04J/VIsI0ZD7wRwVwxNudVbRbT3msYsdi1ZLED5aLPmONgi9QtqG48tRwp/aTQlwF9TR9jtdxNLd/WTQNm0cZ47ABpR2Nq/vbm+LObQ2/vwk4rXcSLkoYB4bq3YulctytqmBPfkOtakC/tuvFzUzUV+JjLnQ9UUt5OR6p1I/x8pggBFHZVnjdViDlxRoCBnQcqUx9ZDg==
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB4787.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 510a5ff3-bca3-4f4a-0a0a-08db51b79279
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 May 2023 00:35:08.0855
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MA2cyY/8Vjx5uNVKK248dj6Q1+zXtqCO/5ZWSY8lMkM3t2X7O5Fjw2JLcYyBxiwUChC+hUB9wgULjoH5uy8syA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4913
X-Proofpoint-GUID: wto32rjjtMe_M922ix5kyDgr7zH026aX
X-Proofpoint-ORIG-GUID: wto32rjjtMe_M922ix5kyDgr7zH026aX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-10_04,2023-05-05_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 lowpriorityscore=0 malwarescore=0 spamscore=0 impostorscore=0 mlxscore=0
 phishscore=0 bulkscore=0 priorityscore=1501 mlxlogscore=999 adultscore=0
 suspectscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2304280000 definitions=main-2305110003
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gRnJpLCBNYXkgMDUsIDIwMjMsIFN0YW5sZXkgQ2hhbmcgd3JvdGU6DQo+IFRoZSBSZWFsdGVr
IFJURCBTb0NzIHdlcmUgZGVzaWduZWQgd2l0aCB0aGUgZ2xvYmFsIHJlZ2lzdGVyIGFkZHJlc3MN
Cj4gb2Zmc2V0IGF0IDB4ODEwMC4gVGhlIGRlZmF1bHQgYWRkcmVzcyBvZmZzZXQgaXMgY29uc3Rh
bnQgYXQNCj4gRFdDM19HTE9CQUxTX1JFR1NfU1RBUlQgKDB4YzEwMCkuIFRoZXJlZm9yZSwgYWRk
IGEgY2hlY2sgaWYgdGhlDQo+IGNvbXBhdGlibGUgbmFtZSBvZiB0aGUgcGFyZW50IGlzIHJlYWx0
ZWsscnRkLWR3YzMsIHRoZW4gZ2xvYmFsDQo+IHJlZ2lzdGVyIHN0YXJ0IGFkZHJlc3Mgd2lsbCBy
ZW1hcCB0byAweDgxMDAuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBTdGFubGV5IENoYW5nIDxzdGFu
bGV5X2NoYW5nQHJlYWx0ZWsuY29tPg0KPiAtLS0NCj4gIHY1IHRvIHY2IGNoYW5nZToNCj4gQ2hh
bmdlIHRoZSBjb21wYXRpYmxlIG5hbWUgdG8gYXZvaWQgdXNpbmcgdGhlIHdpbGRjYXJkLg0KPiAN
Cj4gIHY0IHRvIHY1IGNoYW5nZToNCj4gVXNlIHRoZSBjb21wYXRpYmxlIG5hbWUgb2YgdGhlIHBh
cmVudCB0byBtYXRjaCB0aGlzIHNwZWNpYWwgb2Zmc2V0Lg0KPiANCj4gIHYzIHRvIHY0IGNoYW5n
ZToNCj4gVXNlIHRoZSBjb21wYXRpYmxlIG5hbWUgdG8gc3BlY2lmeSB0aGUgZ2xvYmFsIHJlZ2lz
dGVyIGFkZHJlc3Mgb2Zmc2V0Lg0KPiBJZiB0aGUgY29tcGF0aWJsZSBuYW1lIGlzICJzbnBzLGR3
YzMtcnRrLXNvYyIsIHRoZW4gdGhlIG9mZnNldCB1c2UgMHg4MTAwLg0KPiBPdGhlcndpc2UsIHRo
ZSBvZmZzZXQgaXMgZGVmYXVsdCB2YWx1ZSAweGMxMDAuDQo+IA0KPiAgdjIgdG8gdjMgY2hhbmdl
Og0KPiAxLiAgRml4IHRoZSBkdHNjaGVtYSB2YWxpZGF0aW9uIGVycm9yLg0KPiANCj4gIHYxIHRv
IHYyIGNoYW5nZToNCj4gMS4gQ2hhbmdlIHRoZSBuYW1lIG9mIHRoZSBwcm9wZXJ0eSAic25wcyxn
bG9iYWwtcmVncy1zdGFydGluZy1vZmZzZXQiLg0KPiAyLiBBZGp1c3QgdGhlIGZvcm1hdCBvZiBj
b21tZW50Lg0KPiAzLiBBZGQgaW5pdGlhbCB2YWx1ZSBvZiB0aGUgZ2xvYmFsX3JlZ3Nfc3RhcnRp
bmdfb2Zmc2V0DQo+IDQuIFJlbW92ZSB0aGUgbG9nIG9mIGRldl9pbmZvLg0KPiAtLS0NCj4gIGRy
aXZlcnMvdXNiL2R3YzMvY29yZS5jIHwgMTEgKysrKysrKysrKysNCj4gIGRyaXZlcnMvdXNiL2R3
YzMvY29yZS5oIHwgIDIgKysNCj4gIDIgZmlsZXMgY2hhbmdlZCwgMTMgaW5zZXJ0aW9ucygrKQ0K
PiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdXNiL2R3YzMvY29yZS5jIGIvZHJpdmVycy91c2Iv
ZHdjMy9jb3JlLmMNCj4gaW5kZXggMGJlYWFiOTMyZTdkLi4yNzhjZDFjMzM4NDEgMTAwNjQ0DQo+
IC0tLSBhL2RyaXZlcnMvdXNiL2R3YzMvY29yZS5jDQo+ICsrKyBiL2RyaXZlcnMvdXNiL2R3YzMv
Y29yZS5jDQo+IEBAIC0xODAwLDYgKzE4MDAsMTcgQEAgc3RhdGljIGludCBkd2MzX3Byb2JlKHN0
cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpDQo+ICAJZHdjX3JlcyA9ICpyZXM7DQo+ICAJZHdj
X3Jlcy5zdGFydCArPSBEV0MzX0dMT0JBTFNfUkVHU19TVEFSVDsNCj4gIA0KPiArCWlmIChkZXYt
Pm9mX25vZGUpIHsNCj4gKwkJc3RydWN0IGRldmljZV9ub2RlICpwYXJlbnQgPSBvZl9nZXRfcGFy
ZW50KGRldi0+b2Zfbm9kZSk7DQo+ICsNCj4gKwkJaWYgKG9mX2RldmljZV9pc19jb21wYXRpYmxl
KHBhcmVudCwgInJlYWx0ZWsscnRkLWR3YzMiKSkgew0KPiArCQkJZHdjX3Jlcy5zdGFydCAtPSBE
V0MzX0dMT0JBTFNfUkVHU19TVEFSVDsNCj4gKwkJCWR3Y19yZXMuc3RhcnQgKz0gRFdDM19SVEtf
UlREX0dMT0JBTFNfUkVHU19TVEFSVDsNCj4gKwkJfQ0KPiArDQo+ICsJCW9mX25vZGVfcHV0KHBh
cmVudCk7DQo+ICsJfQ0KPiArDQo+ICAJcmVncyA9IGRldm1faW9yZW1hcF9yZXNvdXJjZShkZXYs
ICZkd2NfcmVzKTsNCj4gIAlpZiAoSVNfRVJSKHJlZ3MpKQ0KPiAgCQlyZXR1cm4gUFRSX0VSUihy
ZWdzKTsNCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdXNiL2R3YzMvY29yZS5oIGIvZHJpdmVycy91
c2IvZHdjMy9jb3JlLmgNCj4gaW5kZXggZDU2NDU3YzAyOTk2Li4xOTY4NjM4ZjI5ZWQgMTAwNjQ0
DQo+IC0tLSBhL2RyaXZlcnMvdXNiL2R3YzMvY29yZS5oDQo+ICsrKyBiL2RyaXZlcnMvdXNiL2R3
YzMvY29yZS5oDQo+IEBAIC04NCw2ICs4NCw4IEBADQo+ICAjZGVmaW5lIERXQzNfT1RHX1JFR1Nf
U1RBUlQJCTB4Y2MwMA0KPiAgI2RlZmluZSBEV0MzX09UR19SRUdTX0VORAkJMHhjY2ZmDQo+ICAN
Cj4gKyNkZWZpbmUgRFdDM19SVEtfUlREX0dMT0JBTFNfUkVHU19TVEFSVAkweDgxMDANCj4gKw0K
PiAgLyogR2xvYmFsIFJlZ2lzdGVycyAqLw0KPiAgI2RlZmluZSBEV0MzX0dTQlVTQ0ZHMAkJMHhj
MTAwDQo+ICAjZGVmaW5lIERXQzNfR1NCVVNDRkcxCQkweGMxMDQNCj4gLS0gDQo+IDIuMzQuMQ0K
PiANCg0KQWNrZWQtYnk6IFRoaW5oIE5ndXllbiA8VGhpbmguTmd1eWVuQHN5bm9wc3lzLmNvbT4N
Cg0KVGhhbmtzLA0KVGhpbmg=
