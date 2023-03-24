Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55FCB6C8902
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Mar 2023 00:10:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231926AbjCXXKL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 19:10:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbjCXXKI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 19:10:08 -0400
Received: from mx0b-00230701.pphosted.com (mx0b-00230701.pphosted.com [148.163.158.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E79C13D52;
        Fri, 24 Mar 2023 16:10:06 -0700 (PDT)
Received: from pps.filterd (m0098572.ppops.net [127.0.0.1])
        by mx0b-00230701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32OMLOF4029356;
        Fri, 24 Mar 2023 16:10:04 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=pfptdkimsnps;
 bh=4QyORZJ3fjFxBxPPSniizVDA6PicV0iwe/+ZaHd4MiU=;
 b=LuItEFK9YhO6P1IVL2isLuBW5xBUJe0oPVPh5+Mis/BrC4qV7mvbaU9nB/AHIKfy9KF9
 FsJinpJRTkF9CBoMHz1SMaR3xhk3T50j+Jf1N3Ghhd2fFLKbwMuJwkjleC4cix58IiGC
 REY2HIGt3WA5HZsDG4GZpywnNm6mnh7G/IPB/38i7GTXad8mExjeBEjUExzZSUc4ZjDi
 T/1Q3lK+mKAcWFolXCRFI+ZxeWC8cDp2i7JvALpACVaZ01XPN4DbQgvv9Ypxua9pzLMA
 GNZMolxWpr8clF84fMm8ZSG6inZewu8kse+sXp1oI/Llu23Cm+WdpJW+z6+SS37OkK4U Og== 
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.73.133])
        by mx0b-00230701.pphosted.com (PPS) with ESMTPS id 3pgxydxbt1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 24 Mar 2023 16:10:04 -0700
Received: from mailhost.synopsys.com (badc-mailhost1.synopsys.com [10.192.0.17])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 69D97400E6;
        Fri, 24 Mar 2023 23:10:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1679699403; bh=4QyORZJ3fjFxBxPPSniizVDA6PicV0iwe/+ZaHd4MiU=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=BKAKdBJ9qVdg2vTb2t3K+g4fdBJljRQCohO63j9A0UDYJ/nIE4auLw3LLDQtdCFUu
         5u/b73Gkzl1jaeHKuGAidaylgrPxjmGRDQrOIxPkw18sTW8gQNzBVMikiyu2jf2Vr1
         Nj/0J7dLMIbWqfY2k5rg/YB18uOchzpeMOCjJ8UbTnTrAga9bMQVdfG8yUEMS9D/52
         HeXTrZkMYyX5rhWHPIwLJdau04I7PaqiGdQzj9D0DF2R8LPB3r4wVRgBhdJ7dmM9Hj
         0TzFLM6XAxUS1WxnrjcFcsaGLgZmVYy/U1jSMjxqtBChl2SRijgU7whEHYudGr55sr
         kayrxA67FFVrA==
Received: from o365relay-in.synopsys.com (us03-o365relay1.synopsys.com [10.4.161.137])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
        by mailhost.synopsys.com (Postfix) with ESMTPS id 148B3A00D5;
        Fri, 24 Mar 2023 23:10:03 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2173.outbound.protection.outlook.com [104.47.59.173])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id 366DC800F6;
        Fri, 24 Mar 2023 23:10:02 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=thinhn@synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.b="d7LQZSg7";
        dkim-atps=neutral
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U5q5uHgupH/b7Ulv6oToGj91M4x1zpPuDL6DL5TE3BZFYlZJ6UTRRy7zNl+SYMmln8nbTt76Os2q1BVRBc3JkHPnSjDV+4+9Gl5iSKBfEmyVs8Ui/4KKkXQXzJQ0RcC5GAmQzr5ZA8/L2RjdZUnNTizufG0AoD4BuPNSOQjcK2zM1PA5B797ngtSSQKUsdMYvIfX9hM81zrw1hZbWQZJTWsJLk3szGT66MC8koGGQjrkrJ+LkiwksIR3UBjZSCEZaDsaFb0uuOVBzWXskdJWSUGH5gbfOQW1Q9K5GqibonAT9n/aGU199LkzMxrTrzGCdQnZn3i6QBZiTXK4l5VPPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4QyORZJ3fjFxBxPPSniizVDA6PicV0iwe/+ZaHd4MiU=;
 b=Xx4nMgsyIvv4n1e/3vSTUitFWZI8JrQJ4TeVFUuT06cKWQ0XKgitGlbbjTtdUgDfr7DJUktA3q+X61f55m1kjD1d0kdMBDS0cgO8D+niOeq76sQFnZqOBk++cyWOH786INGEk6pSvW8dhGHctY7ZcqpFE9pIwyHWmuIyQFmvdcUUXF04e958MewHwVgDJt5p++veAIq/TLjjO2gFwW1MnRWCA0ngJ4IhDUNu9kpidFLu+mOshKaEx10vEaLSm3ndURlFGVA2+3sowlKfHdvcbQRtKRcqvHxXbzgJ0GZUPa9VKhcRCCSx4Jk+FN5RX+BvyinFvHumWBtG8Jkkf0iJjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4QyORZJ3fjFxBxPPSniizVDA6PicV0iwe/+ZaHd4MiU=;
 b=d7LQZSg7DP404jZfkpyvgvp0+srfzdZvXDc/HazTq/QQ38F3vXfqhPjDvTI0J4kkw0/jWacq7evlOtadxeKh+NDTEoOjPlG3QQM9YQkCHMFReUOak4yC2sehVLC7xYXa2WNOs36i3RueOgzu7/F0myXQMIqMjJXF1armmMyoyWQ=
Received: from BYAPR12MB4791.namprd12.prod.outlook.com (2603:10b6:a03:10a::12)
 by BL1PR12MB5286.namprd12.prod.outlook.com (2603:10b6:208:31d::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.39; Fri, 24 Mar
 2023 23:09:59 +0000
Received: from BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::3161:c44d:8bb3:423f]) by BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::3161:c44d:8bb3:423f%3]) with mapi id 15.20.6178.038; Fri, 24 Mar 2023
 23:09:59 +0000
X-SNPS-Relay: synopsys.com
From:   Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To:     Elson Roy Serrao <quic_eserrao@quicinc.com>
CC:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "quic_wcheng@quicinc.com" <quic_wcheng@quicinc.com>,
        "quic_jackp@quicinc.com" <quic_jackp@quicinc.com>
Subject: Re: [PATCH v13 5/6] usb: gadget: Handle function suspend feature
 selector
Thread-Topic: [PATCH v13 5/6] usb: gadget: Handle function suspend feature
 selector
Thread-Index: AQHZXppXTpHEZ4Mtq0SlQtOxTsk0O68Kjj+A
Date:   Fri, 24 Mar 2023 23:09:58 +0000
Message-ID: <20230324230947.cvs37umprqiswr6b@synopsys.com>
References: <1679694482-16430-1-git-send-email-quic_eserrao@quicinc.com>
 <1679694482-16430-6-git-send-email-quic_eserrao@quicinc.com>
In-Reply-To: <1679694482-16430-6-git-send-email-quic_eserrao@quicinc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR12MB4791:EE_|BL1PR12MB5286:EE_
x-ms-office365-filtering-correlation-id: 4ac957a8-0355-494c-0cc9-08db2cbce383
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8/Np50mBclEI2/fah4wS/nFZPsU1sqdt6rEaizIKFkNW6juAQqwIkNjsbjbtyR+IKliskeM3xjub0borQ415KwzSCZXsdip4blyE0zrQkM5BVE4Z0wfIgso7ayurELfEtEl+sft8jQl5Iyw9n0K1h0LQuQ6E4GEEanCvbG9abJ0QFgTviyFjCo3WKYe3TdpeZ7pkY6OEJGr98v3bA1Ws+xVn1fiErU+9E/B9E5icB9suFsSxsfiPW0w3xBF8dYGIK5geINPHk/onxJRvfF7logGQsguypYq00MH+Gg4xbWrTMrF4r3qBP/W0KELzWAWXEDOhuvbK0aKtJvrHj+QkUwFqVYiRWiIHbH8AXYsRotwSTBFe4bWR6Ex6C+cFO9zq7nVHmcEndt1xpI/A0VvY9wVhMCJAg4D8YY3b7wg4WdR15ZXG239pAg9zCDmza4DMcyBG/2EdbC7912JT8oCK6hTe0Ta/lnCfn7PWVfgfDTGz4KNnhMPoA9YBG/Vizjk1UJEGeXh77UzwKgOL0Ic1/UHBErypxHJkH2AaXrE52gYDPvvbfNUT3kRSl5COb3xdnjqUSwONOBGIXDNzER9Bt+KvmcxpE+lF3FU9jvSDg4MmE7itfy66kSK7i1OJjzbtF4jz1vufy+cUy68IxCCaolHSFrA6dJHXKFCU4+W6HYqkoLvj7NPrco8jT1UhfLnxsA/Kh9X1GvLdoCoPQIC4Nw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4791.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(396003)(376002)(366004)(39860400002)(136003)(451199021)(1076003)(26005)(186003)(478600001)(122000001)(76116006)(71200400001)(66476007)(6506007)(2616005)(64756008)(66556008)(66946007)(86362001)(66446008)(8936002)(6512007)(38100700002)(4326008)(5660300002)(2906002)(36756003)(6486002)(6916009)(38070700005)(54906003)(83380400001)(316002)(15650500001)(8676002)(41300700001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bm02SDAvYUlzUGM0RzBjYmJxLzBneXYvRWh4MHU4R205R2krY2w0L0xneG4z?=
 =?utf-8?B?VE1QSzZGa0I5ZUtDTWVXWnFYZjBhY1l3dkVoVTFtaWxDdndpNXBHNzNZQUw1?=
 =?utf-8?B?dElPUHI1UHdCZlJKUjNMZ1crZlo4RUxFWUFqTmE1SElSMEJQY1ZyMzFoQkRN?=
 =?utf-8?B?MzJadGdmcS9Nb3BtKzArajV1cUZPWVpvNS9rMEkzMWJPMGdwQ1FyU1lxV3ZN?=
 =?utf-8?B?T1llMUFESjlpa201M3pZQW9UWkJEVko5U0hYT1lCN3lScnR4ZnFwL0wxbmF0?=
 =?utf-8?B?NDJva0JuZzYxc0UrTm9lOERRSHh5U1A0UkcxNDd0OTFCT20wNkFESUZ1Zjho?=
 =?utf-8?B?NzMvV3ZXMjBiRmxrWTdDbEdONDJWY1h6bHJPc05UZkpKN0FUakJ6ckRhKzB0?=
 =?utf-8?B?VFNKVUxEWkpsSklOZG5MT1ZwNHVjNDVLMFA4UE5qckdKTHBScVI5YnJMRVpE?=
 =?utf-8?B?anRDWDFMNG5nQnZkbVI4NHgyVG96MGZ2TTNiN3cxbTJjaW1BWG9vM2xyL0t2?=
 =?utf-8?B?RDN2a0s2SDlFc0xkZ2RLbnFnaDdLTzdvQU9jd05NUWJWRE5BK0MwSzJ3UmdW?=
 =?utf-8?B?RFZONU5YdnMwdTljOVV2aHZvUHpYSU05UHlXdG5ucWJEVGh1WW9TK3ZVeVdP?=
 =?utf-8?B?WVdiWnBNcG4yMXdBYlIyU2o1enF6ZG9qdzJRM0JtaTU5SzJTSEYwZzRRbmcx?=
 =?utf-8?B?UFkxL244cGZFR09YQXNaZmZVaUtDb3hxSHBIaVF0ajJKVm9PK0tWNldJZ2c1?=
 =?utf-8?B?QS9tQ2prdDROYkJkOENsQ3JBODNFTUkxcHQyekJKVWJpUkZBTVIzaFd4UEcx?=
 =?utf-8?B?RGpHWmdSTWJoL1l6aERTTThhdVZBMUFYVEhCR3dBZSs5TUJsVDZtWG9rZHNi?=
 =?utf-8?B?ZWpYMW9CVWZsOWMrWkJudzBNK2YrdUFVNWxFNStZL1RuM2tDM3dTd0ljZDV2?=
 =?utf-8?B?TmNjSTFveWhNM3gyREdwdDl2SWc3Y0cvNVFHTnhKNmNKUGhxcTRWMStLcjRL?=
 =?utf-8?B?QzNsR1lkU3A1UC9hVW5PeVgxbFllT0h2cWJCSUVyVjA2K21NWWk2b1pjNFNj?=
 =?utf-8?B?S05paGo5cDdoN0JOOWhaL0pUc3ExQnRnSHVKYnIrOS84Vi84NlFCYVV4OXBv?=
 =?utf-8?B?aC9lcWJHQXNvdmVkaldlejVtemF0Z3lwQW1QWWRQQWpST2FDdWJsMmg3YTBK?=
 =?utf-8?B?cGFIcWxSM0tORTBDVkdaVmJ5QW9JYXkxQytpV1VLOGpiNHA4N3BVU0lNWUpH?=
 =?utf-8?B?WkE2SEltd0JFcHp4aUErbEFWRVhkTmNkRHJKSTFvcTk0ZEJUUzU0cjduaW5H?=
 =?utf-8?B?Yi84RlBKRjVGWk51OGkyUWJEUmpGbjhJeEpIZ0xLL1c5N1h5NTI2Y2p2ZkRk?=
 =?utf-8?B?bFY5NDE0ckJBVmg1UHphKzdqUHJBdUlVeUJBdGgyQmVjUGFlYkRLbytQUXN4?=
 =?utf-8?B?WHNJUGFydzh5bzB3UHZvT09qc3hHb2p2bXlXWERSeHZ6cjBjWVN3b0k1M3Fu?=
 =?utf-8?B?MG0zN2hseDFSTUozVFZMQklpbnZINW4rYzlxa1pEMjFSdzF2anpMNVRWK2tX?=
 =?utf-8?B?cXpQdlc2WnBybFRSSHpGK1NZMGZRSVA0OVJPcnN6ZjJQRHU1RG1MRkdtUXFN?=
 =?utf-8?B?Z0xsU2N0TWREWE5aL01aa0srallqM3dIaWpDRFBUWW9ZRFdpU2VaS1NkaEF6?=
 =?utf-8?B?RUFiV0tseTdrTVB2eUtGV0IrTUg5TXhtMkFaSzRYZmhONk1vMGZRRmppNExz?=
 =?utf-8?B?VE5Sa0o3OW9UMnFJSjUwdDhaRHhyM2V1KzF3czZJTEJUTlQzZ2NnUjhlVXNh?=
 =?utf-8?B?YVZ2bVkzeVM3bE1WNEtOZ3k4clcrZE0ybjJDN2pqdThvN0JQSlIwOTNaTU5H?=
 =?utf-8?B?UENtQTZ0SStla3lRTWRMaFh2bUkvbzluekFnSVU5NEtSS0JiVkNzTE5PUUZi?=
 =?utf-8?B?aEtZRGRSWStxUVdzdWZEeVVIWktqaGd3Nm1zZ21hSVgycXN2M3FWdWNwTEFi?=
 =?utf-8?B?Q3lkdUUwc1haZE83QW1TbGRJbW9DR0FTVno4dlJxVkFSdkhvLzlNREFSbzMv?=
 =?utf-8?B?cWRxME5VanFKMyt3NnZTOEFaR0F2eVYyM3UwMWUvaEdEdXBQTFVtVnhadE1K?=
 =?utf-8?B?WjNQZnhPTGNpRm9uSkxYbkVhNVhrTXEvVnZnR1pMRnVNYTVPRkpvK3dVZ2dp?=
 =?utf-8?B?OEE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A9E1021EFA401145931D54C8A5D5EA4A@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 2PjyuXRd09mF5teNmn3gn4Fv8C4ZxJLaNUpFgp2EHpV8faQ+SPaq3C2C5vnVavNPP/9yQ2aSmeR9rYqwrX7ZEAWl/48EDIh8feDFO+zuiKjTiGaBPnE8bTltUJ9Bn8Z9uPkeS/A9F9FRlD4CrEIoZw70s1xdEaMrpFxqehc93eQIdF+Zd8CVweeha7OniU0nRfSeDyWlBHhr0BZwuGYzV/nHPP2xYfMOOgp6lc4PhkQv8mNShzHr466oUYyhV3zbFCoq6Z6R+QmkrY9qIWSlhu2jiaWLRqzSpi7QGDeLkQ//A/9xrWRSHH70xHVmAjO9i5/QrBRvIMiSZRkw5dX5hrbZ7NFx4S7sIIHC+jCOJiisnnIh/SXaVNCOouDdt8CkwCV4Ee/fPPg0jhUoJeD0Fx7I0jvAJSxSkeJP6WaqkWLOMn7oAXn4aLF3rJAf3jnEbpwtH9VZEvb+17koPk4fSizbscHbCQQ9JX4S2isGOREmaQrQf5aG9Wqik7cOdOB6TdEUrkYoRlhq4SpildEFU2BJ6CkyZTO9SMNsfcpDXLrdnRnWUv6cFeEPi8T+LYGDEWSkdft90EBUDUwtqdcJ1MW8VLdvhUQrehpcNgOmDOsGdM6MgP8ra5G7nGd6Mnwcv34oRXm8iOJQwb/lUImyL4Fy6es+PxXrg6qVABaGevwO4v/K0be5Bf+DNLnpQZr+UC8lZcbdcwEK9hbGvVBBe42v5ae2ZnVmK0GyUz3/BE8LqIwBH3M1rkhFYghHHU8xZzSd3JWVTcKTWcGkENIkeZ87m3JMO86vQ1KV17MvKJ+HptpDas6Z3hbV6SVNOQJlfDgBDgf/HQARVGRXvr6VRPDBt5OiOHbSLwYIsCIrskiGaSX0LEZ9SDG2Zov9b/oQOzKjiRpJLDrlSVmE8vg7bw==
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4791.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ac957a8-0355-494c-0cc9-08db2cbce383
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Mar 2023 23:09:58.5078
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AW03Bcc2TIdR1fWJImzoiIbrQhBmOaQjTC3B1NMkH9qQa6DQppCgwoZfBmlk2OKgVrOAxOff08zzLG8YbPP7Dg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5286
X-Proofpoint-ORIG-GUID: xz6iqDOsVQT3L46oqMxwz7QQqTZUV9px
X-Proofpoint-GUID: xz6iqDOsVQT3L46oqMxwz7QQqTZUV9px
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-24_11,2023-03-24_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 malwarescore=0 phishscore=0 mlxlogscore=890 clxscore=1015
 priorityscore=1501 adultscore=0 impostorscore=0 bulkscore=0
 lowpriorityscore=0 mlxscore=0 spamscore=0 suspectscore=0 classifier=spam
 adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2303240176
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gRnJpLCBNYXIgMjQsIDIwMjMsIEVsc29uIFJveSBTZXJyYW8gd3JvdGU6DQo+IFdoZW4gaG9z
dCBzZW5kcyBmdW5jdGlvbiBzdXNwZW5kIGZlYXR1cmUgc2VsZWN0b3IgdG8gdGhlIGRldmljZSwN
Cj4gaW5zcGVjdCB0aGUgcmVjZWl2ZWQgcGFja2V0IGFuZCB0cmlnZ2VyIGZ1bmN0aW9uIHN1c3Bl
bmQgb3INCj4gZnVuY3Rpb24gcmVzdW1lIGFjY29yZGluZ2x5LiBJbnNwZWN0IHRoZSByZW1vdGUg
d2FrZXVwIGJpdCBhbmQNCj4gYXJtIHRoZSBmdW5jdGlvbiBmb3IgcmVtb3RlIHdha2V1cCBpZiBp
dCBpcyB3YWtldXAgY2FwYWJsZS4gQWxzbw0KPiBob3N0IHF1ZXJpZXMgdGhlIGZ1bmN0aW9uIHdh
a2V1cCBjYXBhYmlsaXR5ICB0aHJvdWdoIGEgZ2V0IHN0YXR1cw0KPiByZXF1ZXN0IGJlZm9yZSBz
ZW5kaW5nIGZ1bmN0aW9uIHJlc3VtZS4gSGFuZGxlIHN1Y2ggcmVxdWVzdHMgaW4NCj4gY29tcG9z
aXRlIGxheWVyLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogRWxzb24gUm95IFNlcnJhbyA8cXVpY19l
c2VycmFvQHF1aWNpbmMuY29tPg0KPiAtLS0NCj4gIGRyaXZlcnMvdXNiL2dhZGdldC9jb21wb3Np
dGUuYyB8IDY1ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrLS0tLQ0KPiAg
MSBmaWxlIGNoYW5nZWQsIDYwIGluc2VydGlvbnMoKyksIDUgZGVsZXRpb25zKC0pDQo+IA0KPiBk
aWZmIC0tZ2l0IGEvZHJpdmVycy91c2IvZ2FkZ2V0L2NvbXBvc2l0ZS5jIGIvZHJpdmVycy91c2Iv
Z2FkZ2V0L2NvbXBvc2l0ZS5jDQo+IGluZGV4IDIxMTE3MzIuLmQxZDdmODkgMTAwNjQ0DQo+IC0t
LSBhL2RyaXZlcnMvdXNiL2dhZGdldC9jb21wb3NpdGUuYw0KPiArKysgYi9kcml2ZXJzL3VzYi9n
YWRnZXQvY29tcG9zaXRlLmMNCj4gQEAgLTk0MSw2ICs5NDEsOSBAQCBzdGF0aWMgdm9pZCByZXNl
dF9jb25maWcoc3RydWN0IHVzYl9jb21wb3NpdGVfZGV2ICpjZGV2KQ0KPiAgCQlpZiAoZi0+ZGlz
YWJsZSkNCj4gIAkJCWYtPmRpc2FibGUoZik7DQo+ICANCj4gKwkJLyogU2VjdGlvbiA5LjEuMS42
LCBkaXNhYmxlIHJlbW90ZSB3YWtldXAgd2hlbiBkZXZpY2UgaXMgcmVzZXQgKi8NCj4gKwkJZi0+
ZnVuY193YWtldXBfYXJtZWQgPSBmYWxzZTsNCj4gKw0KPiAgCQliaXRtYXBfemVybyhmLT5lbmRw
b2ludHMsIDMyKTsNCj4gIAl9DQo+ICAJY2Rldi0+Y29uZmlnID0gTlVMTDsNCj4gQEAgLTIwMDYs
OSArMjAwOSwyMCBAQCBjb21wb3NpdGVfc2V0dXAoc3RydWN0IHVzYl9nYWRnZXQgKmdhZGdldCwg
Y29uc3Qgc3RydWN0IHVzYl9jdHJscmVxdWVzdCAqY3RybCkNCj4gIAkJZiA9IGNkZXYtPmNvbmZp
Zy0+aW50ZXJmYWNlW2ludGZdOw0KPiAgCQlpZiAoIWYpDQo+ICAJCQlicmVhazsNCj4gLQkJc3Rh
dHVzID0gZi0+Z2V0X3N0YXR1cyA/IGYtPmdldF9zdGF0dXMoZikgOiAwOw0KPiAtCQlpZiAoc3Rh
dHVzIDwgMCkNCj4gLQkJCWJyZWFrOw0KPiArDQo+ICsJCWlmIChmLT5nZXRfc3RhdHVzKSB7DQo+
ICsJCQlzdGF0dXMgPSBmLT5nZXRfc3RhdHVzKGYpOw0KPiArCQkJaWYgKHN0YXR1cyA8IDApDQo+
ICsJCQkJYnJlYWs7DQo+ICsJCX0gZWxzZSB7DQo+ICsJCQkvKiBTZXQgRDAgYW5kIEQxIGJpdHMg
YmFzZWQgb24gZnVuYyB3YWtldXAgY2FwYWJpbGl0eSAqLw0KPiArCQkJaWYgKGYtPmNvbmZpZy0+
Ym1BdHRyaWJ1dGVzICYgVVNCX0NPTkZJR19BVFRfV0FLRVVQKSB7DQo+ICsJCQkJc3RhdHVzIHw9
IFVTQl9JTlRSRl9TVEFUX0ZVTkNfUldfQ0FQOw0KPiArCQkJCWlmIChmLT5mdW5jX3dha2V1cF9h
cm1lZCkNCj4gKwkJCQkJc3RhdHVzIHw9IFVTQl9JTlRSRl9TVEFUX0ZVTkNfUlc7DQo+ICsJCQl9
DQo+ICsJCX0NCj4gKw0KPiAgCQlwdXRfdW5hbGlnbmVkX2xlMTYoc3RhdHVzICYgMHgwMDAwZmZm
ZiwgcmVxLT5idWYpOw0KPiAgCQlicmVhazsNCj4gIAkvKg0KPiBAQCAtMjAzMCw4ICsyMDQ0LDQ0
IEBAIGNvbXBvc2l0ZV9zZXR1cChzdHJ1Y3QgdXNiX2dhZGdldCAqZ2FkZ2V0LCBjb25zdCBzdHJ1
Y3QgdXNiX2N0cmxyZXF1ZXN0ICpjdHJsKQ0KPiAgCQkJaWYgKCFmKQ0KPiAgCQkJCWJyZWFrOw0K
PiAgCQkJdmFsdWUgPSAwOw0KPiAtCQkJaWYgKGYtPmZ1bmNfc3VzcGVuZCkNCj4gKwkJCWlmIChm
LT5mdW5jX3N1c3BlbmQpIHsNCj4gIAkJCQl2YWx1ZSA9IGYtPmZ1bmNfc3VzcGVuZChmLCB3X2lu
ZGV4ID4+IDgpOw0KPiArCQkJLyogU2V0RmVhdHVyZShGVU5DVElPTl9TVVNQRU5EKSAqLw0KPiAr
CQkJfSBlbHNlIGlmIChjdHJsLT5iUmVxdWVzdCA9PSBVU0JfUkVRX1NFVF9GRUFUVVJFKSB7DQo+
ICsJCQkJaWYgKCEoZi0+Y29uZmlnLT5ibUF0dHJpYnV0ZXMgJg0KPiArCQkJCSAgICAgIFVTQl9D
T05GSUdfQVRUX1dBS0VVUCkgJiYNCj4gKwkJCQkgICAgICh3X2luZGV4ICYgVVNCX0lOVFJGX0ZV
TkNfU1VTUEVORF9SVykpDQo+ICsJCQkJCWJyZWFrOw0KPiArDQo+ICsJCQkJZi0+ZnVuY193YWtl
dXBfYXJtZWQgPSAhISh3X2luZGV4ICYNCj4gKwkJCQkJCQkgIFVTQl9JTlRSRl9GVU5DX1NVU1BF
TkRfUlcpOw0KPiArDQo+ICsJCQkJaWYgKHdfaW5kZXggJiBVU0JfSU5UUkZfRlVOQ19TVVNQRU5E
X0xQKSB7DQo+ICsJCQkJCWlmIChmLT5zdXNwZW5kICYmICFmLT5mdW5jX3N1c3BlbmRlZCkgew0K
PiArCQkJCQkJZi0+c3VzcGVuZChmKTsNCj4gKwkJCQkJCWYtPmZ1bmNfc3VzcGVuZGVkID0gdHJ1
ZTsNCj4gKwkJCQkJfQ0KPiArCQkJCS8qDQo+ICsJCQkJICogSGFuZGxlIGNhc2VzIHdoZXJlIGhv
c3Qgc2VuZHMgZnVuY3Rpb24gcmVzdW1lDQo+ICsJCQkJICogdGhyb3VnaCBTZXRGZWF0dXJlKEZV
TkNUSU9OX1NVU1BFTkQpIGJ1dCBsb3cgcG93ZXINCj4gKwkJCQkgKiBiaXQgcmVzZXQNCj4gKwkJ
CQkgKi8NCj4gKwkJCQl9IGVsc2Ugew0KPiArCQkJCQlpZiAoZi0+cmVzdW1lICYmIGYtPmZ1bmNf
c3VzcGVuZGVkKSB7DQo+ICsJCQkJCQlmLT5yZXN1bWUoZik7DQo+ICsJCQkJCQlmLT5mdW5jX3N1
c3BlbmRlZCA9IGZhbHNlOw0KPiArCQkJCQl9DQo+ICsJCQkJfQ0KPiArCQkJLyogQ2xlYXJGZWF0
dXJlKEZVTkNUSU9OX1NVU1BFTkQpICovDQo+ICsJCQl9IGVsc2UgaWYgKGN0cmwtPmJSZXF1ZXN0
ID09IFVTQl9SRVFfQ0xFQVJfRkVBVFVSRSkgew0KPiArCQkJCWYtPmZ1bmNfd2FrZXVwX2FybWVk
ID0gZmFsc2U7DQo+ICsNCj4gKwkJCQlpZiAoZi0+cmVzdW1lICYmIGYtPmZ1bmNfc3VzcGVuZGVk
KSB7DQo+ICsJCQkJCWYtPnJlc3VtZShmKTsNCj4gKwkJCQkJZi0+ZnVuY19zdXNwZW5kZWQgPSBm
YWxzZTsNCj4gKwkJCQl9DQo+ICsJCQl9DQo+ICsNCj4gIAkJCWlmICh2YWx1ZSA8IDApIHsNCj4g
IAkJCQlFUlJPUihjZGV2LA0KPiAgCQkJCSAgICAgICJmdW5jX3N1c3BlbmQoKSByZXR1cm5lZCBl
cnJvciAlZFxuIiwNCj4gQEAgLTI1NzQsNyArMjYyNCwxMiBAQCB2b2lkIGNvbXBvc2l0ZV9yZXN1
bWUoc3RydWN0IHVzYl9nYWRnZXQgKmdhZGdldCkNCj4gIAkJY2Rldi0+ZHJpdmVyLT5yZXN1bWUo
Y2Rldik7DQo+ICAJaWYgKGNkZXYtPmNvbmZpZykgew0KPiAgCQlsaXN0X2Zvcl9lYWNoX2VudHJ5
KGYsICZjZGV2LT5jb25maWctPmZ1bmN0aW9ucywgbGlzdCkgew0KPiAtCQkJaWYgKGYtPnJlc3Vt
ZSkNCj4gKwkJCS8qDQo+ICsJCQkgKiBDaGVjayBmb3IgZnVuY19zdXNwZW5kZWQgZmxhZyB0byBz
ZWUgaWYgdGhlIGZ1bmN0aW9uIGlzDQo+ICsJCQkgKiBpbiBVU0IzIEZVTkNUSU9OX1NVU1BFTkQg
c3RhdGUuIEluIHRoaXMgY2FzZSByZXN1bWUgaXMNCj4gKwkJCSAqIGRvbmUgdmlhIEZVTkNUSU9O
X1NVU1BFTkQgZmVhdHVyZSBzZWxlY3Rvci4NCj4gKwkJCSAqLw0KPiArCQkJaWYgKGYtPnJlc3Vt
ZSAmJiAhZi0+ZnVuY19zdXNwZW5kZWQpDQo+ICAJCQkJZi0+cmVzdW1lKGYpOw0KPiAgCQl9DQo+
ICANCj4gLS0gDQo+IDIuNy40DQo+IA0KDQpSZXZpZXdlZC1ieTogVGhpbmggTmd1eWVuIDxUaGlu
aC5OZ3V5ZW5Ac3lub3BzeXMuY29tPg0KDQpUaGFua3MsDQpUaGluaA==
