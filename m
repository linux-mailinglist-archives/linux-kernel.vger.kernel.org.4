Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 189FB6E7064
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 02:20:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231566AbjDSAUz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 20:20:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229597AbjDSAUv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 20:20:51 -0400
Received: from mx0a-00230701.pphosted.com (mx0a-00230701.pphosted.com [148.163.156.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBDC35B84;
        Tue, 18 Apr 2023 17:20:50 -0700 (PDT)
Received: from pps.filterd (m0297266.ppops.net [127.0.0.1])
        by mx0a-00230701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33IK0eMx003413;
        Tue, 18 Apr 2023 17:20:34 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=pfptdkimsnps;
 bh=ccPJh//RavXJKc8D36O86A9fdjHvhG358Ebur7WKaeI=;
 b=QO3+RCD0/AD+6m1sGy0ua64ZqzvWKHIyu4D8U6E6B//KScHiUfk9nR/6/iCWFUnPMvyj
 yK99ehA96JQDSvYJNaL4jBDwQTOIqkQpI83ctHRyc1kloNWNI6tkPl9/vjYJjg1lflf9
 Y87WtWB4A2VAiZBl7+5GhT6DJA3BUu/TFSGljk/JiIn7o06HznI3NXLN+FT+F/T/6I0x
 oWc6AF7D2dYAkT74yOhq+LOwc5nVDco9564/vLFjc+HLxESxrpFaravOtiGhkM/TJyfd
 KLFM6Z9/+NQHqDNw8t7KbB6MXB1J1BWR4hB8JtbBWUfXRdL6QzYNaJlicaUvsq2KIPnq Ew== 
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.73.133])
        by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 3pyu666dgh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 18 Apr 2023 17:20:33 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1681863633; bh=ccPJh//RavXJKc8D36O86A9fdjHvhG358Ebur7WKaeI=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=TZkfQKoWXujCigtmfrrwnmSSaTXdtHCazkyeAApLGe5JEtxpEFqPx9wn6XourkWxc
         ftXt/9Gle9d1bX5Ta68NGfiFd37W8zIXBykWmaWLzBCNBdve910AFZl9KbAemRdv1u
         9oIpl77VfA3VSkMb/FZi+c82Kz3PAdrfhwI/vmfx5Sn7XScsaBLBTTabdHTQbUQX6y
         E5jhfIn0snW4u/j9KLK7I7CsVjUd47IoBJMH7IpcJtgAwG3dIj9EQTKONnBm1Y4LAE
         OlZzDZ+/YWp1YVcMQpJMqZvAYQBEXI369/YPmpUYSsO9AhxDuMd7nY1cRWETdoq7tr
         5bGVzs3BQ0YoA==
Received: from mailhost.synopsys.com (sv2-mailhost2.synopsys.com [10.205.2.134])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits)
         client-signature RSA-PSS (2048 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 7583240C4F;
        Wed, 19 Apr 2023 00:20:33 +0000 (UTC)
Received: from o365relay-in.synopsys.com (us03-o365relay3.synopsys.com [10.4.161.139])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
        by mailhost.synopsys.com (Postfix) with ESMTPS id B3A01A00BA;
        Wed, 19 Apr 2023 00:20:32 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=oJVpgJhv;
        dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id 650B440DEF;
        Wed, 19 Apr 2023 00:20:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NPzyscyjF/5jvD0OL3acJeF1hHXfqW6W7hXkrhfxmJHRrzjZgJPog74x4w6BzUgfIPzLIGK9Jk3Jo3tpEne/md9QuQG5FF1nS+p3wHD7J2BuOFCBmbGeVY3tSeEJ8zshqaLLC9mUEgmEN013JH6KKK2Fej/9wpe5qQrNkP0RwfKHUNRX0MSMwAF8sEmj7lHtLeLmWigXeduzCOvTQm0Mzde7vPf+klO+iRmJSKI37fPpKoHpGY8T0dKT9gfZw2T8ev6EJAXgnaVPvazDaKvpY6gkxJTQFmlJFHCQC5ttSfqrwmGzusprJeKOo27ykqc6mtnNibr/i8uBkstTwa2Q9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ccPJh//RavXJKc8D36O86A9fdjHvhG358Ebur7WKaeI=;
 b=j57Y9iLBR6GF50140F1aClm1quwtkahzaHJpD5PD6443WW0ztPdO/XhYyg4G43KEIx5yDNN7e8rXDD4awTG2PCtuvWmYOYEUEd/VGbSGg8NtSKBceUI6kKvcKqbIUBQ+jCi/p1s24rQG2R+9GaCcnWAorXBpPmDoWg+oJdLN6/IJnYiohrnD3RL4H0v6sHEPAC8ehDqnu8rSlJPh9LPEbY8Ehl/IMCUy5Dy2M3sDXaveTgvshDH7lWKn1WVngRbid5MWzfVEZasnivqKngIFhixiq/VFxF2r/PheHQsf4qKq0FxMRJwhcFXBIFEfVBX2DuGL14/bDXoQYSBfggmucA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ccPJh//RavXJKc8D36O86A9fdjHvhG358Ebur7WKaeI=;
 b=oJVpgJhvHTGnj/GOmz1zepUODlKUWTJLWqwoXPhciH1qAJkMugfMtHANt/3Nv5Jh93RAnGCGOZugRTkTriatrD3adfVJ3D5VwuuisFxJaLJugbTDSLiU93DGVMZDmtsNQytGYj0i5xHWznTaPBmzWZmJcMUMhTBThvr6BKNDIh8=
Received: from BYAPR12MB4791.namprd12.prod.outlook.com (2603:10b6:a03:10a::12)
 by PH7PR12MB7283.namprd12.prod.outlook.com (2603:10b6:510:20a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.45; Wed, 19 Apr
 2023 00:20:27 +0000
Received: from BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::3103:ba85:b667:315d]) by BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::3103:ba85:b667:315d%6]) with mapi id 15.20.6298.045; Wed, 19 Apr 2023
 00:20:27 +0000
X-SNPS-Relay: synopsys.com
From:   Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To:     Stanley Chang <stanley_chang@realtek.com>
CC:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Felipe Balbi <balbi@kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 1/2] usb: dwc3: core: add support for disabling
 High-speed park mode
Thread-Topic: [PATCH v3 1/2] usb: dwc3: core: add support for disabling
 High-speed park mode
Thread-Index: AQHZbfAta6P3eikHuUKCqhSFbI+D868xzY+A
Date:   Wed, 19 Apr 2023 00:20:27 +0000
Message-ID: <20230419002017.rnrduds7ci4bdftu@synopsys.com>
References: <20230413100914.7890-1-stanley_chang@realtek.com>
In-Reply-To: <20230413100914.7890-1-stanley_chang@realtek.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR12MB4791:EE_|PH7PR12MB7283:EE_
x-ms-office365-filtering-correlation-id: c182043f-b26f-4300-bd5c-08db406be087
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: HffpVuuE57PJIsiyYRoyC77o7Ou/zEwqmjcsZmlA77+S6XJYj3IBokVnkFI7WaleUixeRUNni4DU+jbemULeYrR+o0+mUO0tO9U+ern5tkYjOw9FKQl85KTJ7JRPN7LpuMoP8dMK+r0E1TV+Y23JSN6fTo+1UHCvlasC+vS5NxeKga301JlUguEkHXelI7OJM6hpz4oRakBmDKPOmYy+qAvAcv8LfwoVtLtx6mk6TDwZbA5EBT6++0r6z7cFaS732YePCGv9OwZ3irxVXmqN3IG50ch/ikwBF9MzEfVxAw220J1bO6hielgT/sFU6L+v98PPAvKSd1Ig393DvdaEFvbM9ZG9R1AVrAXmqjR11NqT1/Y+xOZpIKi4v9YmrxnQXq/G7sqziaHkystvxWGpwj4hD9DPH56nGF2j/7eu+LsxtYmhoT/C5MBAUr0z7MuonlOW7vqg2JR6yCtNdVz2PgZWlr4CD04sRwBLhXSmghn/hmwHPt5+xBc3UM5Livirkw4mPoLPN9Fq2W3zpi8BHYbv6DsK6BZ7YI88v14XXMXRyAuHOqnTltdbLsq9V5lnZuehf7k+MfUxIL5BX1a4jAQPkndMu5pBihapxhwm1mvjrQdKySE1KBhYPDWdHtBa
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4791.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(376002)(346002)(366004)(136003)(39860400002)(451199021)(38100700002)(5660300002)(8936002)(8676002)(2616005)(38070700005)(83380400001)(2906002)(41300700001)(186003)(316002)(26005)(6506007)(1076003)(122000001)(6512007)(71200400001)(66446008)(66476007)(76116006)(66946007)(66556008)(86362001)(54906003)(6916009)(4326008)(36756003)(64756008)(6486002)(478600001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dTVsdGZjU2dCQmRxUm4wKzNGQ052bGQwTUprVG9YYVhkZkdQU0lsZCtnd09r?=
 =?utf-8?B?WXEva1RWVjdEbm1uTmtBTmE5amhDYVZGdnNaaW9rdWY2UTlQRkRNWC9OR09h?=
 =?utf-8?B?dDdZZFBZQ3RVTi9DY0FoclBtVEhEU0RMQ25IUzZhM0FYRnRnQlplYXNVVmFF?=
 =?utf-8?B?QmhTZVBMRFQydjMra2hlQU10RFZxWWhCeU5lbGhycGtXZWZnMkJzUGpmZ0Zq?=
 =?utf-8?B?TGQzZVFJcTk5eDlGVzJUQ0hyTFNhN1JtMUxDREVCOVJ1VzFLdWwvUExLcGEx?=
 =?utf-8?B?bEE2OXZpMDZiQ3RjOXoyTkxMZHMyVUk3aXpzbEJGS2FCc1VUODB1OFRBNUFo?=
 =?utf-8?B?dlJhL1pTYm12ampxVEx6ekdUQ1owdmM4U3dieGErT05jTXBCbzBBNjB2UmhS?=
 =?utf-8?B?eDVBTWtXU1RBYmhXbmYrcm1Qa0hpZlIwYnFtYWlFa1JjcTl5NVBVTW5IS3Nu?=
 =?utf-8?B?Mm1lZlhFK3B0SGQ0aEVXMDRTQk81OXU3Z3BLcUFqUy9QOWpoQTQrSTZvdkhK?=
 =?utf-8?B?MitCdXRoYkhhWXVETk5oZE1PWk1RUVJwRW1hN2xXZ1pGTnFMNWVBR3NiWmNE?=
 =?utf-8?B?emZEL1JCYm1XemtWNDRNTmdTWk03SmVKOWc2K0FMbThpdEQyYzgrSWROY0Rh?=
 =?utf-8?B?NzUwSTBGUFhtMlZXSTFLWFUxbnFRMWdRVGVNUVhZZ0hOMUxQTWUwNnFpbGpC?=
 =?utf-8?B?Z2YwTEpMY3dnZ3ZsbXdIOEJaRWdnU1IzUll5czB5YkE3WFRGUGw2VUdsVzh5?=
 =?utf-8?B?K3YzS0VBR1JFOHRyVzFpbWU5VndPNmR6UEJKaXBBM1hpajRiREZFdW9Jb1l5?=
 =?utf-8?B?ZVlOSWxSRklTcGlyTjlSTzVVVC9YZm9aV2ttcGNXbkJiTDA4U0FONHZGb05V?=
 =?utf-8?B?VHY3TDYwK0RFUW9jWXc5YTI5MmZmTm1NdWtrM3NuOXRxNHpZUmI4R0JrT2Jq?=
 =?utf-8?B?OHZhdTcxRGpoQWlGcUlnS1prcXBXVDI2NFBSUXVPdFAvRC9CTy93dU1jZXlE?=
 =?utf-8?B?WjM5WnRxdXRaUkYwelg1RG5jRjlqT3hXNVhQVXNIZzdsSEtBM0dyd1dMNVFE?=
 =?utf-8?B?NEJqWDlDVzdEL1ljRERVYldDRUl2Wm5aKzI1eEVEZnkrSGQ5RUFMdmlPdnJT?=
 =?utf-8?B?elhoNDNsL2VudmFDZ0FOd1QzSFVLUjFDUGoyd3h4MDd1bDFtYVNTRS9WOEZ4?=
 =?utf-8?B?UWN6amw4b1NkWDhubnVsK1BEaVhNaHkzZFBwZzhMbTBicFp3TjA1M21Ic24x?=
 =?utf-8?B?d29xclFtOFlDMEJ1MlRCRUVkUEpCSEYyRFYxa2FBdnRMMWc1bFhBdTBLZWtM?=
 =?utf-8?B?WmJPc0d4eWdwSEExbUVEenFTL0dMeVFHdHF0WGpYQ1FraDZFbEY4ZmtFVXFB?=
 =?utf-8?B?dEY4NXFFSk1LZklia3FnRVozSkx6YXA1UVNZR2EzQ21aMjZsajRUejd6M0xW?=
 =?utf-8?B?MG14dVlhZHl1M1JsQ2d2ejRFS1VmMWl0WWFta0Nac1ovd25saXZRTVRxcmdk?=
 =?utf-8?B?N1c0a1NBS0RiRm5TWkhXMGhvNEpTc2VOK1BqYkI2Wm5lbzZVUW1hdSs1b3gz?=
 =?utf-8?B?MW9LT0d4WitnSTBWWGpnbGR5VSt0R2Y4U21jaVlwNjBKbHA3c0JRcC9OaUlu?=
 =?utf-8?B?b1FzK1lPNzVWZlQxdWtpR0dNdjd6dmI0eFB3VVRVWU93SnZ6UFBxQWd2dHJ5?=
 =?utf-8?B?VTFwc3FGV2pjakcwNXJTYkxvRTFmaUNqOGlzcGFiUkRwMG1YOGZPQmJWSzVm?=
 =?utf-8?B?ZTJxc21XZGlNaGJlOHRSNGxqZStHVHA4TzNnVDhBK0VCNjVwMEkyQUs3OVJ3?=
 =?utf-8?B?YXpvdklCN3owOGpuSmJXM09YVlpMNy90NHFhOExTUHlYQUlGbjBTNEdobEJh?=
 =?utf-8?B?MnBKdXFjK2NqVllHbjV5a3JHZHNuK2JNNmIyMGY5aGtNQWpLdzZhbFA0ZnNU?=
 =?utf-8?B?TDd1dVkyVWorSzM0SkVSdnpaMitkV0ZXZ0M3dHdveW1yQllNdW1CQnJzanJE?=
 =?utf-8?B?bnZHUmViRWUwZDh0M3l4U3VCQXZrU0lNZktsM1lIT2xqZi9NOGU4dG1wdGs4?=
 =?utf-8?B?YmhPWG5Fa1FvR05SUit0bm9FRS9CTDRINXhseXVuV2lxQUhXTVJ2aUVVNlR0?=
 =?utf-8?B?VTE0ZTBmOUNHQXE2S1dDUWVYWUt1WkxUdUw2QkVidnZZU09Ta2E2TXZEdC8v?=
 =?utf-8?B?b3c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7BADA2C58811F842B73EFAB40B722C60@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?ZmtSbEY2SUZHU1NVZ2xDa0V5RVhKL2dEMWhXZUU1THlwYkRlbzVhYWVUWW5D?=
 =?utf-8?B?RW5JdWhVVzJlK1lrOTdRZnNZd20vMy8vUEFkSUlDcURiY3o3NUdlYkxENVpF?=
 =?utf-8?B?SDd2R01EWGU1UmxWckVKcmhWOHY4Z3hiNXJIZEszVHU2TTJDdVdhZG4yMHpJ?=
 =?utf-8?B?ZXJzZlNRdDljUHMrR2pJd3hCMGtnK0Y5M0x6dzl5UFdVMy93SlUyRWt2MnVT?=
 =?utf-8?B?UElKaVdvN0xDbjh3L3BtZDRaUi9FeGNIL0ZEZDJWNlB5a3hiZkVtUzJuai9Q?=
 =?utf-8?B?bitRS3htdkRVMUtOcGxvRkh0OUkxN1J2OWhKWmtkQ2JIU010MWxJRWoxSCta?=
 =?utf-8?B?cjlyM3VYOGlGcDBSZmVLbjNTZjdUc1hsZ3lpVTdBNzZXZVY0dzZ4YlR1Zysy?=
 =?utf-8?B?RUVwS0pQTitIY1Y5U0RrbjV6cEFZZVcxdnJnV2JqcXJHWXA3RjhBTW1hcDBE?=
 =?utf-8?B?QVJHWHlhdHU4em05bzZPc2RIa3E5eThDRm55RlpRUlFuVGE3V0l5UURuTjdz?=
 =?utf-8?B?SjRndm9Ed1ZWWHlXK2EzZ1VTUENnTStqdkxqck9YK1RrSmpjLzdxMDRXSXd0?=
 =?utf-8?B?eHVYTklXUDZCUk5DZGhyYVpxTytPNnQxT2podEluYTNtZDZIbjRSOUQ1Z256?=
 =?utf-8?B?VHdYam54MGZxeVBmNEg0b080OGtkbjdqK2RoODMreTBUTlVEbDN4dzNuNlg5?=
 =?utf-8?B?VTExK0ZTdndCSVNDcjhyZ0p0K1NWa3Z5ak9kdEhBV282S1R2Qm1pUmVET0NR?=
 =?utf-8?B?dUhsb2h1c1BYRkF2dDVXNU5jdEVlaFNXQVE4TklaZDZrTDF5Y3hpL2FkbVI4?=
 =?utf-8?B?YWIxcDFmaC9jNzVOZnAzMVN5bWh1UVBFSXo1dkRkKzQrQStIeHZaTURjd0U4?=
 =?utf-8?B?VXZEeDF6eGN3VGh1RzdDTDlhOVN6Tlh5MjRhNi92eGlzQWdlcHZib0oxcUpN?=
 =?utf-8?B?VmljNWFsa0FBaEFVVWt5MHFhSFh3cU03VGU2MkpKdlZPczlxamFFOXROWGs5?=
 =?utf-8?B?M255Q1VMNldsNWw3TUtPZTdGc2ZpOVY0dXB6b0xvMUVXcWtKQ3F0S09sajUy?=
 =?utf-8?B?dnZXcmxGSm5ZUUNJUkdXY0kvdUVQd3lsV2JzZjQ4dDcyV1FSMi8vbzFFcWIy?=
 =?utf-8?B?RDVBMWJ1SkdFV2VVRFBUZWYwbzZacGJDOG1EQU55MGp5Q0pLeGVKOElsSWlN?=
 =?utf-8?B?VzRYckdiTFdNZmZKOFU1RXByL0NTUDVqNmFsdmx5eFRuaVp1S1hndUx1NXhz?=
 =?utf-8?Q?myyVVkhu6DAEd+I?=
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4791.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c182043f-b26f-4300-bd5c-08db406be087
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Apr 2023 00:20:27.5321
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VMVU3vv0aVXfiI7extP5YeAst70UNOu2gxLakIm7Dq9j90X67REQpqS923kLnUdkzpeNvGe+n+i2KOuzYpIC8A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7283
X-Proofpoint-ORIG-GUID: E2aCghIC7DrQrRWpCU18qAtjbTQb53a1
X-Proofpoint-GUID: E2aCghIC7DrQrRWpCU18qAtjbTQb53a1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-18_17,2023-04-18_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 bulkscore=0 malwarescore=0 phishscore=0 mlxscore=0 clxscore=1011
 impostorscore=0 spamscore=0 lowpriorityscore=0 priorityscore=1501
 suspectscore=0 adultscore=0 mlxlogscore=999 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2304190001
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1LCBBcHIgMTMsIDIwMjMsIFN0YW5sZXkgQ2hhbmcgd3JvdGU6DQo+IFNldHRpbmcgdGhl
IFBBUktNT0RFX0RJU0FCTEVfSFMgYml0IGluIHRoZSBEV0MzX1VTQjNfR1VDVEwxLg0KPiBXaGVu
IHRoaXMgYml0IGlzIHNldCB0byAnMScgYWxsIEhTIGJ1cyBpbnN0YW5jZXMgaW4gcGFyayBtb2Rl
IGFyZSBkaXNhYmxlZA0KPiANCj4gRm9yIHNvbWUgVVNCIHdpZmkgZGV2aWNlcywgaWYgZW5hYmxl
IHRoaXMgZmVhdHVyZSBpdCB3aWxsIHJlZHVjZSB0aGUNCj4gcGVyZm9ybWFuY2UuIFRoZXJlZm9y
ZSwgYWRkIGFuIG9wdGlvbiBmb3IgZGlzYWJsaW5nIEhTIHBhcmsgbW9kZSBieQ0KPiBkZXZpY2Ut
dHJlZS4NCj4gDQo+IEluIFN5bm9wc3lzJ3MgZHdjMyBkYXRhIGJvb2s6DQo+IEluIGEgZmV3IGhp
Z2ggc3BlZWQgZGV2aWNlcyB3aGVuIGFuIElOIHJlcXVlc3QgaXMgc2VudCB3aXRoaW4gOTAwbnMg
b2YgdGhlDQo+IEFDSyBvZiB0aGUgcHJldmlvdXMgcGFja2V0LCB0aGVzZSBkZXZpY2VzIHNlbmQg
YSBOQUsuIFdoZW4gY29ubmVjdGVkIHRvDQo+IHRoZXNlIGRldmljZXMsIGlmIHJlcXVpcmVkLCB0
aGUgc29mdHdhcmUgY2FuIGRpc2FibGUgdGhlIHBhcmsgbW9kZSBpZiB5b3UNCj4gc2VlIHBlcmZv
cm1hbmNlIGRyb3AgaW4geW91ciBzeXN0ZW0uIFdoZW4gcGFyayBtb2RlIGlzIGRpc2FibGVkLA0K
PiBwaXBlbGluaW5nIG9mIG11bHRpcGxlIHBhY2tldCBpcyBkaXNhYmxlZCBhbmQgaW5zdGVhZCBv
bmUgcGFja2V0IGF0IGEgdGltZQ0KPiBpcyByZXF1ZXN0ZWQgYnkgdGhlIHNjaGVkdWxlci4gVGhp
cyBhbGxvd3MgdXAgdG8gMTIgTkFLcyBpbiBhIG1pY3JvLWZyYW1lDQo+IGFuZCBpbXByb3ZlcyBw
ZXJmb3JtYW5jZSBvZiB0aGVzZSBzbG93IGRldmljZXMuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBT
dGFubGV5IENoYW5nIDxzdGFubGV5X2NoYW5nQHJlYWx0ZWsuY29tPg0KPiAtLS0NCj4gdjIgdG8g
djMgY2hhbmdlOg0KPiAxLiBBZGQgdGhlIGNvbW1lbnQgbWVzc2FnZS4NCj4gMi4gY2MgdGhlIHJp
Z2h0IG1haW50YWluZXJzLg0KPiAtLS0NCj4gIGRyaXZlcnMvdXNiL2R3YzMvY29yZS5jIHwgNSAr
KysrKw0KPiAgZHJpdmVycy91c2IvZHdjMy9jb3JlLmggfCA0ICsrKysNCj4gIDIgZmlsZXMgY2hh
bmdlZCwgOSBpbnNlcnRpb25zKCspDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy91c2IvZHdj
My9jb3JlLmMgYi9kcml2ZXJzL3VzYi9kd2MzL2NvcmUuYw0KPiBpbmRleCA0NzZiNjM2MTg1MTEu
LjhmYmM5MmE1ZjJjYiAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy91c2IvZHdjMy9jb3JlLmMNCj4g
KysrIGIvZHJpdmVycy91c2IvZHdjMy9jb3JlLmMNCj4gQEAgLTEyMzMsNiArMTIzMyw5IEBAIHN0
YXRpYyBpbnQgZHdjM19jb3JlX2luaXQoc3RydWN0IGR3YzMgKmR3YykNCj4gIAkJaWYgKGR3Yy0+
cGFya21vZGVfZGlzYWJsZV9zc19xdWlyaykNCj4gIAkJCXJlZyB8PSBEV0MzX0dVQ1RMMV9QQVJL
TU9ERV9ESVNBQkxFX1NTOw0KPiAgDQo+ICsJCWlmIChkd2MtPnBhcmttb2RlX2Rpc2FibGVfaHNf
cXVpcmspDQo+ICsJCQlyZWcgfD0gRFdDM19HVUNUTDFfUEFSS01PREVfRElTQUJMRV9IUzsNCj4g
Kw0KPiAgCQlpZiAoRFdDM19WRVJfSVNfV0lUSElOKERXQzMsIDI5MEEsIEFOWSkgJiYNCj4gIAkJ
ICAgIChkd2MtPm1heGltdW1fc3BlZWQgPT0gVVNCX1NQRUVEX0hJR0ggfHwNCj4gIAkJICAgICBk
d2MtPm1heGltdW1fc3BlZWQgPT0gVVNCX1NQRUVEX0ZVTEwpKQ0KPiBAQCAtMTU1NSw2ICsxNTU4
LDggQEAgc3RhdGljIHZvaWQgZHdjM19nZXRfcHJvcGVydGllcyhzdHJ1Y3QgZHdjMyAqZHdjKQ0K
PiAgCQkJCSJzbnBzLHJlc3VtZS1ocy10ZXJtaW5hdGlvbnMiKTsNCj4gIAlkd2MtPnBhcmttb2Rl
X2Rpc2FibGVfc3NfcXVpcmsgPSBkZXZpY2VfcHJvcGVydHlfcmVhZF9ib29sKGRldiwNCj4gIAkJ
CQkic25wcyxwYXJrbW9kZS1kaXNhYmxlLXNzLXF1aXJrIik7DQo+ICsJZHdjLT5wYXJrbW9kZV9k
aXNhYmxlX2hzX3F1aXJrID0gZGV2aWNlX3Byb3BlcnR5X3JlYWRfYm9vbChkZXYsDQo+ICsJCQkJ
InNucHMscGFya21vZGUtZGlzYWJsZS1ocy1xdWlyayIpOw0KPiAgCWR3Yy0+Z2ZsYWRqX3JlZmNs
a19scG1fc2VsID0gZGV2aWNlX3Byb3BlcnR5X3JlYWRfYm9vbChkZXYsDQo+ICAJCQkJInNucHMs
Z2ZsYWRqLXJlZmNsay1scG0tc2VsLXF1aXJrIik7DQo+ICANCj4gZGlmZiAtLWdpdCBhL2RyaXZl
cnMvdXNiL2R3YzMvY29yZS5oIGIvZHJpdmVycy91c2IvZHdjMy9jb3JlLmgNCj4gaW5kZXggNDc0
M2U5MThkY2FmLi4zMDkwN2ZmY2IzZWMgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvdXNiL2R3YzMv
Y29yZS5oDQo+ICsrKyBiL2RyaXZlcnMvdXNiL2R3YzMvY29yZS5oDQo+IEBAIC0yNjMsNiArMjYz
LDcgQEANCj4gICNkZWZpbmUgRFdDM19HVUNUTDFfREVWX0ZPUkNFXzIwX0NMS19GT1JfMzBfQ0xL
CUJJVCgyNikNCj4gICNkZWZpbmUgRFdDM19HVUNUTDFfREVWX0wxX0VYSVRfQllfSFcJCUJJVCgy
NCkNCj4gICNkZWZpbmUgRFdDM19HVUNUTDFfUEFSS01PREVfRElTQUJMRV9TUwkJQklUKDE3KQ0K
PiArI2RlZmluZSBEV0MzX0dVQ1RMMV9QQVJLTU9ERV9ESVNBQkxFX0hTCQlCSVQoMTYpDQo+ICAj
ZGVmaW5lIERXQzNfR1VDVEwxX1JFU1VNRV9PUE1PREVfSFNfSE9TVAlCSVQoMTApDQo+ICANCj4g
IC8qIEdsb2JhbCBTdGF0dXMgUmVnaXN0ZXIgKi8NCj4gQEAgLTExMDIsNiArMTEwMyw4IEBAIHN0
cnVjdCBkd2MzX3NjcmF0Y2hwYWRfYXJyYXkgew0KPiAgICoJCQlnZW5lcmF0aW9uIGFmdGVyIHJl
c3VtZSBmcm9tIHN1c3BlbmQuDQo+ICAgKiBAcGFya21vZGVfZGlzYWJsZV9zc19xdWlyazogc2V0
IGlmIHdlIG5lZWQgdG8gZGlzYWJsZSBhbGwgU3VwZXJTcGVlZA0KPiAgICoJCQlpbnN0YW5jZXMg
aW4gcGFyayBtb2RlLg0KPiArICogQHBhcmttb2RlX2Rpc2FibGVfaHNfcXVpcms6IHNldCBpZiB3
ZSBuZWVkIHRvIGRpc2FibGUgYWxsIEhpc2hTcGVlZA0KPiArICoJCQlpbnN0YW5jZXMgaW4gcGFy
ayBtb2RlLg0KPiAgICogQHR4X2RlX2VtcGhhc2lzX3F1aXJrOiBzZXQgaWYgd2UgZW5hYmxlIFR4
IGRlLWVtcGhhc2lzIHF1aXJrDQo+ICAgKiBAdHhfZGVfZW1waGFzaXM6IFR4IGRlLWVtcGhhc2lz
IHZhbHVlDQo+ICAgKgkwCS0gLTZkQiBkZS1lbXBoYXNpcw0KPiBAQCAtMTMxOCw2ICsxMzIxLDcg
QEAgc3RydWN0IGR3YzMgew0KPiAgCXVuc2lnbmVkCQlkaXNfdHhfaXBnYXBfbGluZWNoZWNrX3F1
aXJrOjE7DQo+ICAJdW5zaWduZWQJCXJlc3VtZV9oc190ZXJtaW5hdGlvbnM6MTsNCj4gIAl1bnNp
Z25lZAkJcGFya21vZGVfZGlzYWJsZV9zc19xdWlyazoxOw0KPiArCXVuc2lnbmVkCQlwYXJrbW9k
ZV9kaXNhYmxlX2hzX3F1aXJrOjE7DQo+ICAJdW5zaWduZWQJCWdmbGFkal9yZWZjbGtfbHBtX3Nl
bDoxOw0KPiAgDQo+ICAJdW5zaWduZWQJCXR4X2RlX2VtcGhhc2lzX3F1aXJrOjE7DQo+IC0tIA0K
PiAyLjM0LjENCj4gDQoNCkFja2VkLWJ5OiBUaGluaCBOZ3V5ZW4gPFRoaW5oLk5ndXllbkBzeW5v
cHN5cy5jb20+DQoNClRoYW5rcywNClRoaW5o
