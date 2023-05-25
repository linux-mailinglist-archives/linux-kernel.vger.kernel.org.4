Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D49857101F0
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 02:18:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231898AbjEYASv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 20:18:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229658AbjEYASn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 20:18:43 -0400
Received: from mx0a-00230701.pphosted.com (mx0a-00230701.pphosted.com [148.163.156.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA551B3;
        Wed, 24 May 2023 17:18:41 -0700 (PDT)
Received: from pps.filterd (m0297266.ppops.net [127.0.0.1])
        by mx0a-00230701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34OMi92d022477;
        Wed, 24 May 2023 17:18:38 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=pfptdkimsnps;
 bh=jIh0XyJmR4CviA3MtGaDer5sWjHf/tANRqvIApSZsxA=;
 b=bctVSrUFbSvmGGjgavSCsn60tcyb/xlZFG1jpf8Qb9+vG/+GaUPWD8qyGXXGZZv9A2vf
 12xwnlqV7525OndtIbPPzd56IB/G1CalrBWCSC/wvC3dskX/vlVksG47eqKmVPdzqElm
 FY8p9wH6OKiJP17YQu3x8YGXek/9VTGEH8C/Yufy7/ioQVCs/4OAFpmIhaLATsdpZIYH
 3KUECdBsyRKKAINwVB49OVYYiVWtzQMOAEZXdFk0KUb3idYXjey/t1ukI7FrgOo6NzZG
 RMtxO4edHr4d805yGprY771nz1zGKN40Y/O8xwRyX/P7LsXHZSxYbjpumFEWrCfeebVJ Ng== 
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.87.133])
        by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 3qsumq0cym-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 24 May 2023 17:18:38 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1684973918; bh=jIh0XyJmR4CviA3MtGaDer5sWjHf/tANRqvIApSZsxA=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=Xfaus59PNtGM9nDstMjFDcTZhvjgpBWZpnw64hxBCIhK04Afmg2M/18Ka3X1bZyMU
         FAABsFh2ay4YolKFgdodlCTqwq1x+qKVA4Cj+fs+p6vFRfbgBrJ5rejYymtKC8u17P
         kFby1zzwoD656neURfUtCnT123XJvjWN0Mo5JVhSFMndqUgX99qtfAoK2uAh1D4LLt
         k13IFU//p3i0K8rTs2m7HoO6CutN/5APL5eBfgpDwE0NCweqxWJ62MLf/Gc5RO33xj
         W0MzjPY26Rap4VQhCpojAJFkaVPNBWdyg1+2gltCt9u3QHRHamO4tVPax5MgGr0rh7
         Q5/ZN3Zt0mFKQ==
Received: from mailhost.synopsys.com (us03-mailhost2.synopsys.com [10.4.17.18])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits)
         client-signature RSA-PSS (2048 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id CEA614063A;
        Thu, 25 May 2023 00:18:37 +0000 (UTC)
Received: from o365relay-in.synopsys.com (us03-o365relay3.synopsys.com [10.4.161.139])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
        by mailhost.synopsys.com (Postfix) with ESMTPS id 294D6A0062;
        Thu, 25 May 2023 00:18:36 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=lzZhNrfo;
        dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2104.outbound.protection.outlook.com [104.47.58.104])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id C1FDA40636;
        Thu, 25 May 2023 00:18:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RdxiGWrNIT7UZuOR04Ooq36A9/JotwEqXrl6DziCagJ4DESBI2Uwx5NYKM8hXn+wmH/8nbYzGkvgP1Qf7hE+y77NvP9LkjCG9mXbjOsS30fbRuhCSTeRAqT8k8IAy2lSdxmzcG0gYDnxiAOBBvO5Zkbh2DbvGKKgIg6Ou2Dv65nYKAnrBW6sqKWANV4zot+zeYqFNmb0D+keI1gzEFNlf9sflFe45WgCdIbxaBWGxmhSje+8u5F39is4v83PsgNNwcGL7ODYjFMzjLSPU8DX9td8cq+BiF92BGY0+OvXUVZwOxpe2cbWrA3gJp9RU6dmG9s05gCQcFXFOIpVF+k7OQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jIh0XyJmR4CviA3MtGaDer5sWjHf/tANRqvIApSZsxA=;
 b=mSi68tLoULucBTpi88s3Z337J4T3NjFtTjmWXuUncSFWbpKQGj3yT1ywJj33jT5bBlIxxwZaootxix186c0IKITKjiDhLyQJmAetFX7ARXB/4i1J1YDaPhCAThiC1WMS0gTH8OlKgTg2xWeWd1bpGocPdHN1BY80sAQ1qzkdkd8tKOGCDnEJRFwC3leEiMvgThsTQKDWjPbUxIC8HWjU2ex+7ecLBE1P6i9vG29Bs/WKlD+5TSe5cAISVFcWOyWm8+pukdfxuXAFyTOYqW/A0C5BjBo7AAXdqBL40o4fHUNjaG5pRfAoBTytNokeZqrcPXPedOtYpY6m4pKJMWVYSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jIh0XyJmR4CviA3MtGaDer5sWjHf/tANRqvIApSZsxA=;
 b=lzZhNrfoQOSUvElBHhaEkr/2sXLiV1BZQVD82OPgDPVvXJmlD3JIGp8lcfxepemEKxi5JL4vuO4ZIdl+0MY+eRlvcF3FPO9MxLRqtnUa5kjVGnEKBfHimck06gDArOXvU1Zs4K3WrlIRm4TRq+x84uo7C8mYsszkYa7djmbSEwk=
Received: from BN8PR12MB4787.namprd12.prod.outlook.com (2603:10b6:408:a1::11)
 by MW6PR12MB9000.namprd12.prod.outlook.com (2603:10b6:303:24b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.28; Thu, 25 May
 2023 00:18:30 +0000
Received: from BN8PR12MB4787.namprd12.prod.outlook.com
 ([fe80::aefb:f59d:8ee2:501a]) by BN8PR12MB4787.namprd12.prod.outlook.com
 ([fe80::aefb:f59d:8ee2:501a%4]) with mapi id 15.20.6411.028; Thu, 25 May 2023
 00:18:29 +0000
X-SNPS-Relay: synopsys.com
From:   Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To:     Krishna Kurapati PSSNV <quic_kriskura@quicinc.com>
CC:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "quic_ppratap@quicinc.com" <quic_ppratap@quicinc.com>,
        "quic_wcheng@quicinc.com" <quic_wcheng@quicinc.com>,
        "quic_jackp@quicinc.com" <quic_jackp@quicinc.com>,
        "quic_ugoswami@quicinc.com" <quic_ugoswami@quicinc.com>
Subject: Re: [RFC] usb: dwc3: gadget: Fix amount of data copied from event buf
 to cache
Thread-Topic: [RFC] usb: dwc3: gadget: Fix amount of data copied from event
 buf to cache
Thread-Index: AQHZi8uJ8yaHXEonWUKmsB+vQuMnU69mzdyAgABFewCAAU57gIAAZU2AgAFeHgA=
Date:   Thu, 25 May 2023 00:18:29 +0000
Message-ID: <20230525001822.ane3zcyyifj2kuwx@synopsys.com>
References: <20230521100330.22478-1-quic_kriskura@quicinc.com>
 <20230522211651.rr2r3caz6ni7m6xr@synopsys.com>
 <e0f0275a-9418-5aa7-58c6-4ac9ae03e0ae@quicinc.com>
 <20230523212241.av5tts233p5hlodm@synopsys.com>
 <0dab321e-3a55-aef5-a392-5860e98bb12e@quicinc.com>
In-Reply-To: <0dab321e-3a55-aef5-a392-5860e98bb12e@quicinc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN8PR12MB4787:EE_|MW6PR12MB9000:EE_
x-ms-office365-filtering-correlation-id: 6918e08f-e43c-4e83-03bb-08db5cb590cf
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: RFJa1REZbjkaOgQ9ft+9HIqrZOLRsdFTVTCHXhXlMxkFWpK2VKmFYdOiy5Hl826wEHWMPHHzGKYSYfCtAEtU1tTVeN+VBwIIeixuDdKOvlrKG77nS8SFommY3LhMYxwIKyROut8Q4Z4PDwoaGX/XtE0+7EQCh1AYNqVkLx/acZGSYbi6mgX1yJ81D7abWHEOV4rCez5UBocGhLdT3XHBbEb5vaLm6qUs2kwBiuldz3tlifhfbbM7skl+bjFpJe2JNU/vMmKXZkFiog5ixbMB2MMamN1rInKdvI+m/fr/t/yHj/D/5CFsqG6qJ5u+i1k5bP5Mzg4t0d6VPpP92HxM3N65u2qWWWrN+1K7vB3jvcVMFvYH38LsJ6xA0cFK4RgkZfcejNPGJvNH3s7g2+9CbCCTa+6WZGEHx4gP+Xki6lQioThagouJV8GKBfj5RtPp+9jORoo6UG1Pjk9YCpv463HtzPLNX5qrhqqLa6S4OMYimCtHWiyFNYztzSeybZY753WsDi2qTvVEzNc1RynuJOndHasPU9uhFLjdptx+JrCJcYg2hq1dMQN3Z4VfC3184zUKkdVadff4V4qDHMhWDULoWRW2lTyrCCehzAlnveEowLbt6jMt0zjkNFYjrLx3
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB4787.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(396003)(136003)(376002)(346002)(366004)(451199021)(41300700001)(6486002)(71200400001)(8936002)(8676002)(122000001)(26005)(186003)(5660300002)(1076003)(6506007)(6512007)(53546011)(36756003)(38100700002)(2906002)(38070700005)(86362001)(2616005)(76116006)(66476007)(66446008)(66946007)(66556008)(64756008)(91956017)(54906003)(478600001)(316002)(4326008)(83380400001)(6916009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dUZOemNuTWJETHFPanlTM2lpOGpmc0hmbHBWYWNsd25tWFpwTWNHYitIVWdX?=
 =?utf-8?B?c0NrTGgvQllMVVMrSkxIZXdCMjlIakRqLzZkU1ppc2dzbVY2MHNMUTFRQmxC?=
 =?utf-8?B?UjlUd0o1SkZSajFFRUJFUnFNZnZFTVJoandCTkU2S3NDVzF2cnNhL0MvZ0g0?=
 =?utf-8?B?cU5vTGxiQjVna1BYSjdwN01CZklBRHhLdzRyRXdkVkVva29pS3lLV1VwdXMw?=
 =?utf-8?B?NWJ4U2JiM1hJZTQzbEcrWjEwRTZVaUc4b0t1V1RQZm5kUnJLZml4SGVzbUdL?=
 =?utf-8?B?M0FtRFQ0Nk1pcjhWa0NPdEw4MXVlRU5mcG5GOU5YRzltYmlRSVBtSitVcyth?=
 =?utf-8?B?Wm1jc25BTVRmNW0ycDNKWDFuZFozL0duRXBSZkJLeUxRV3poaWIzYURmR2Mw?=
 =?utf-8?B?SXI0Ym9zSnRTdm9ubWNpTXN2ejRIcWREeFppTXM5dVNtbFQydy9BckIvbHJS?=
 =?utf-8?B?RUZNQTdxQnhLTjBoZzYyVitEMnlWTVNiYzBwOFF3MzdrVXBlRDMvazIvU08y?=
 =?utf-8?B?Z3I0V3JKTU5ENndrV0dnS1NxSEE4cncyY0lkd29vNzQ5OEx0NFpYK3YrZklQ?=
 =?utf-8?B?T2s4clFvcjBwVHNzNmJmS3o5WjhaWCsvWW56ZVVGY24yK3B1OUlycEQ5dldR?=
 =?utf-8?B?R1dWRmVCQ2xtdFQ4UlprdFBwd0RmU0ZGTmcyM2FHR1V0NUtXK1VNS3paSDQx?=
 =?utf-8?B?MGlGZW0rNWF1bHd6U2QvaGh6b2FEVTY1TDlRcEtqemZmam1WM0lSSmVkOFd3?=
 =?utf-8?B?alJuSkhNV3luM200L2NQQURZa1I4Z25aOEU4NG42N1Mrc0ZyYUt1V1pvaS9o?=
 =?utf-8?B?OE5ZSjJEeTFHVTBLKzNQa2wwbkQrZjN0MzRvN3dvdkIrRWNsSVd6cEc5UGRu?=
 =?utf-8?B?dFJPUHpPNFpXZnNuVHMxTzVUZGR6aVgyMHd1b3JDclBTV2ttM3I5MWZyRnJD?=
 =?utf-8?B?bG1CalY4TTNwYVhwRmZBcWR2T0dVbHorOHBzZWJhRFpEV3V2ZndFbkRWMFRl?=
 =?utf-8?B?OVdRT295dUlUOUl5K0djMXhTSVc0dFVzd2RSZkFKTGh4QmRwMDAwZDNweEVz?=
 =?utf-8?B?V1hiOCtOR3dtSWR5QWI2V1dBVzJCTXBrUTczYitIOWlnaEhPeWpmbnZWcnc1?=
 =?utf-8?B?amtMWUlzT0trQllDZThJYTgvVnNMdW1wcU02SGlEUTE2WUJNcW5BWUhsd3N5?=
 =?utf-8?B?czJENDdSYktEZy9pc21OMlVvQmh0OVo1TGQ2N1poVG04REdOYnNrZ0Y5NGVI?=
 =?utf-8?B?NUh5SmRYVHZtOUFWZ3BmVlluUHNiVmFtRjBBbG5PYWJ5WXFFTnIyWHl5bEZI?=
 =?utf-8?B?a25YUGNEN0s0SHYyNHlxcXB2eG9GZ2ZsdHNFUXYrM1lLb0xIQjVvRTAzUFFF?=
 =?utf-8?B?ajRXNVEvSURMQ0pVUkJPdVloUFpqSnp0SDlybHVjWHF3RDN1SHg0RzJwL2s3?=
 =?utf-8?B?U1R6WklndTg5TVErb1ZRak5jaTY0TGU3MHZFRWdhUHdvaEpZbHliSE8zbG5C?=
 =?utf-8?B?NEtPeW1wck5SOEpxTWJNY05ZRHQvUWEvVjh3c2ZpRmQ0clJ2dUt6RlR4Tito?=
 =?utf-8?B?RFJmcGNUTmhSNWR5cU5mbGlNK3NpZVh2QmRiNHRsWW4vbjliQUlVSysxRmd3?=
 =?utf-8?B?SkhqTGd5VDdLWkRNUElYQVVEcDlzTUl4SEJXOXd1M2l6TVNVVWFLUzhGSzdF?=
 =?utf-8?B?SlpPcjNja1YrMWZYMmlWbzNvMytrQkZseUcwdlFUU29kVDE1SG1rYUpNYkd3?=
 =?utf-8?B?MTlKNFhzdlFUTXpWNnNKRlRwK1JpQmJrSGVXMm5sb2hmY3RmeERBN1AweFNS?=
 =?utf-8?B?OTJMdDdKMjhHQnp4Z0VuRXQrTHRGOFN4dUJKcXN1OUUrMnR1ei9VVElGRVEz?=
 =?utf-8?B?VUV2RkFLRUxjT29JUW1BNkZTSmhxRTNrMjkxWDBueDBxWFgrYjIwY1FYeWtr?=
 =?utf-8?B?MmpnbzV4OFA4VlhhTXc5ZlYxNFQ0Z0ViRXg2ZDFrMUpRbzBwOWN2QjZPSzdW?=
 =?utf-8?B?ZEpxWC9BNFhDVXY4Y1hOY1ZPZVhkZ3lBaUFEMW9uRUdWNWZYQ2QyYkNSamo4?=
 =?utf-8?B?RnIvN1lCT0l2SG1DQXN2aEpCSDF3cUVwMFJSM1N4YWloL1E3K1piZlUwRWVV?=
 =?utf-8?Q?T1dzFPUneo4PeG9Enbs3p+KEa?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0AE3A9AAC1B55644AE1701D77EDF9642@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: vMeUE0iwpGzcak/zESKGDV7JXo9VC/yQV2Z29bPEWpEgkeNI/h2oKa/4L2cP2pxvV8SNSter0pGGLPcbyx1gOez6hANNWPEa1YD2K4643i3b92SrWJwgNdZTxVw7fBTT8nQrT3WIFiiEOMJ4dpoRLmIglKEa628hS0frEG2BBXvG4aePITOht6OheSxGOCZVxmzEzaVX6MkGbY9XdbTr7Uqi9BWdqo6HhW9powsSuCBS6kK63F4ZYVudIA1DJW5BVnNCOyFA1bs8/XUdY138/w/hs3a7utqoqMNdaMHWt8lkEnuLr/w9fxYTfkvJZk3CNM7T46xj3KAq1OQvwf39iQtFDmX9hTt5m2f9zxFGL8icUeIVhr3RpgQJqs2tMqP3/fEWHAKyMXl8iPa1uNGkvsSRedsJdy6eQyCtsR8Mu5GSS3V0NALHpFeVDdWEive3UkIXsfuKbkrjTL851m8WMn6K0FUcytcMG87QSGgkxQAmlUB2N6JckJt+Frpltxiok7GuKvp0sHf/MkEtSfd4Ebv6eOd0fKtrdSGGshmyVKow5IbzVJYNsoXkrIW1y8IXpndw8myi1KOfFyCiaDC0CcHt9dldPpGfkv+z65ECOiNlNXvrmUQzGlJgjlH7dCtMXc+DESR47DfmSNNG22AuY42l5kXjyeW6Ok4Mkf5WrC0eGjlp1+WDkRBD4mPw2gczBghSrgcfcmPxcjfGU7IU3HhsMRUcBOZFpDwHPUCfEf3jXPIeEqk9LKq9evQNaDKJGaR7p1uWdVakhS9mL7/V0iQWVfNXcCZq5xAiVLZC4n9c3iHvAcV30ocHZq0Gh/ryMH1R/SeGMihjAqFsUZiofUCFUP3umzuwKZNM/IsQgPgK2Xt1h7n2+WducQAPPc5Cs3SJJ+N22WmvMPEHdSSPtg==
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB4787.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6918e08f-e43c-4e83-03bb-08db5cb590cf
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 May 2023 00:18:29.1004
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TvBPjmdHaYJ5T31Uh9j+tZOjuW7deyHkKS/QCpNC4zKHmvb2EP6dR+gIK5+BIeqk2v1TOh8Xpbf+Xz9NYfw51g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB9000
X-Proofpoint-GUID: aYk69irpLcBpPt8eC7tgA5mjv2hcdPBD
X-Proofpoint-ORIG-GUID: aYk69irpLcBpPt8eC7tgA5mjv2hcdPBD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-24_17,2023-05-24_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 malwarescore=0 adultscore=0 impostorscore=0 spamscore=0 priorityscore=1501
 phishscore=0 mlxscore=0 clxscore=1015 lowpriorityscore=0 bulkscore=0
 suspectscore=0 mlxlogscore=753 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2304280000 definitions=main-2305250001
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCBNYXkgMjQsIDIwMjMsIEtyaXNobmEgS3VyYXBhdGkgUFNTTlYgd3JvdGU6DQo+IA0K
PiANCj4gT24gNS8yNC8yMDIzIDI6NTIgQU0sIFRoaW5oIE5ndXllbiB3cm90ZToNCj4gPiBPbiBU
dWUsIE1heSAyMywgMjAyMywgS3Jpc2huYSBLdXJhcGF0aSBQU1NOViB3cm90ZToNCj4gPiA+IA0K
PiA+ID4gDQo+ID4gPiBPbiA1LzIzLzIwMjMgMjo0NyBBTSwgVGhpbmggTmd1eWVuIHdyb3RlOg0K
PiA+ID4gPiBPbiBTdW4sIE1heSAyMSwgMjAyMywgS3Jpc2huYSBLdXJhcGF0aSB3cm90ZToNCj4g
PiA+ID4gPiBJbiB0aGUgY3VycmVudCBpbXBsZW1lbnRhdGlvbiwgdGhlIGNoZWNrX2V2ZW50X2J1
ZiBjYWxsIHJlYWRzIHRoZQ0KPiA+ID4gPiA+IEdFVk5UQ09VTlQgcmVnaXN0ZXIgdG8gZGV0ZXJt
aW5lIHRoZSBhbW91bnQgb2YgZXZlbnQgZGF0YSBnZW5lcmF0ZWQNCj4gPiA+ID4gPiBhbmQgY29w
aWVzIGl0IGZyb20gZXYtPmJ1ZiB0byBldi0+Y2FjaGUgYWZ0ZXIgbWFza2luZyBpbnRlcnJ1cHQu
DQo+ID4gPiA+ID4gDQo+ID4gPiA+ID4gRHVyaW5nIGNvcHkgaWYgdGhlIGFtb3VudCBvZiBkYXRh
IHRvIGJlIGNvcGllZCBpcyBtb3JlIHRoYW4NCj4gPiA+ID4gPiAobGVuZ3RoIC0gbHBvcyksIHdl
IGZpbGwgdGhlIGV2LT5jYWNoZSB0aWxsIHRoZSBlbmQgb2YgNDA5NiBieXRlDQo+ID4gPiA+ID4g
YnVmZmVyIGFsbG9jYXRlZCBhbmQgdGhlbiBzdGFydCBmaWxsaW5nIGZyb20gdGhlIHRvcCAobHBv
cyA9IDApLg0KPiA+ID4gPiA+IA0KPiA+ID4gPiA+IEluIG9uZSBpbnN0YW5jZSBvZiBTTU1VIGNy
YXNoIGl0IGlzIG9ic2VydmVkIHRoYXQgR0VWTlRDT1VOVCByZWdpc3Rlcg0KPiA+ID4gPiA+IHJl
YWRzIG1vcmUgdGhhbiA0MDk2IGJ5dGVzOg0KPiA+ID4gPiA+IA0KPiA+ID4gPiA+IGR3YzNfcmVh
ZGwgICBiYXNlPTB4ZmZmZmZmYzAwOTFkYzAwMCAgb2Zmc2V0PTUwMTg4ICB2YWx1ZT02MzQ4OA0K
PiA+ID4gPiA+IA0KPiA+ID4gPiA+IChvZmZzZXQgPSA1MDE4OCAtPiAweEM0MEMpICAtPiByZWFk
cyA2MzQ4OCBieXRlcw0KPiA+ID4gPiA+IA0KPiA+ID4gPiA+IEFzIHBlciBjcmFzaCBkdW1wOg0K
PiA+ID4gPiA+IGR3Yy0+bHBvcyA9IDIwNTYNCj4gPiA+ID4gPiANCj4gPiA+ID4gPiBhbmQgZXZ0
LT5idWYgaXMgYXQgMHhGRkZGRkZDMDA5MTg1MDAwIGFuZCB0aGUgY3Jhc2ggaXMgYXQNCj4gPiA+
ID4gPiAweEZGRkZGRkMwMDkxODYwMDAuIFRoZSBkaWZmIHdoaWNoIGlzIGV4YWN0bHkgMHgxMDAw
IGJ5dGVzLg0KPiA+ID4gPiA+IA0KPiA+ID4gPiA+IFdlIGZpcnN0IG1lbWNweSAyMDQwIGJ5dGVz
IGZyb20gKGJ1ZiArIGxwb3MpIHRvIChidWYgKyAweDEwMDApLg0KPiA+ID4gPiA+IA0KPiA+ID4g
PiA+IEFuZCB0aGVuIHdlIGNvcHkgdGhlIHJlc3Qgb2YgdGhlIGRhdGEgKDY0Mzg4IC0gMjA0MCkg
ZnJvbSBiZWdpbm5pbmcNCj4gPiA+ID4gPiBvZiBkd2MtPmV2X2J1Zi4gV2hpbGUgZG9pbmcgc28g
d2UgZ28gYmV5b25kIGJvdW5kcyBhcyB3ZSBhcmUgdHJ5aW5nDQo+ID4gPiA+ID4gdG8gbWVtY3B5
IDYyMzQ4IGJ5dGVzIGludG8gYSA0SyBidWZmZXIgcmVzdWx0aW5nIGluIGNyYXNoLg0KPiA+ID4g
PiA+IA0KPiA+ID4gPiA+IEZpeCB0aGlzIGJ5IGxpbWl0aW5nIHRoZSB0b3RhbCBkYXRhIGJlaW5n
IGNvcGllZCB0byBldi0+bGVuZ3RoIHRvDQo+ID4gPiA+ID4gYXZvaWQgY29weWluZyBkYXRhIGJl
eW9uZCBib3VuZHMuIE1vcmVvdmVyIHRoaXMgaXMgbG9naWNhbCBiZWNhdXNlIGlmDQo+ID4gPiA+
ID4gdGhlIGNvbnRyb2xsZXIgZ2VuZXJhdGVkIGV2ZW50cyBtb3JlIHRoYW4gdGhlIHNpemUgb2Yg
cmluZyBidWZmZXIsDQo+ID4gPiA+ID4gc29tZSBvZiB0aGVtIG1pZ2h0IGhhdmUgYmVlbiBvdmVy
d3JpdHRlbiBieSB0aGUgY29udHJvbGxlci4NCj4gPiA+ID4gPiANCj4gPiA+ID4gPiBTaWduZWQt
b2ZmLWJ5OiBLcmlzaG5hIEt1cmFwYXRpIDxxdWljX2tyaXNrdXJhQHF1aWNpbmMuY29tPg0KPiA+
ID4gPiA+IC0tLQ0KPiA+ID4gPiA+IE9ubHkgb25lIGluc3RhbmNlIG9mIHRoaXMgY3Jhc2ggd2Fz
IG9ic2VydmVkIHNvIGZhci4gQXMgcGVyIHRoZQ0KPiA+ID4gPiA+IGRhdGFib29rOg0KPiA+ID4g
PiA+IA0KPiA+ID4gPiA+ICJUaGUgY29udHJvbGxlciBhbHdheXMgbGVhdmVzIG9uZSBlbnRyeSBm
cmVlIGluIGVhY2ggRXZlbnQgQnVmZmVyLg0KPiA+ID4gPiA+IFdoZW4gdGhlIEV2ZW50IEJ1ZmZl
ciBpcyBhbG1vc3QgZnVsbCwgaGFyZHdhcmUgd3JpdGVzIHRoZSBFdmVudA0KPiA+ID4gPiA+IEJ1
ZmZlciBPdmVyZmxvdyBldmVudCBhbmQgdGhlIFVTQiBldmVudHVhbGx5IGdldHMgc3RhbGxlZCB3
aGVuDQo+ID4gPiA+ID4gZW5kcG9pbnRzIHN0YXJ0IHJlc3BvbmRpbmcgTlJEWSBvciB0aGUgbGlu
ayBsYXllciBzdG9wcyByZXR1cm5pbmcNCj4gPiA+ID4gPiBjcmVkaXRzIChpbiBTdXBlclNwZWVk
KS4gVGhpcyBldmVudCBpcyBhbiBpbmRpY2F0aW9uIHRvIHNvZnR3YXJlIHRoYXQNCj4gPiA+ID4g
PiBpdCBpcyBub3QgcHJvY2Vzc2luZyBldmVudHMgcXVpY2tseSBlbm91Z2guIER1cmluZyB0aGlz
IHRpbWUsIGV2ZW50cw0KPiA+ID4gPiA+IGFyZSBxdWV1ZWQgdXAgaW50ZXJuYWxseS4gV2hlbiBz
b2Z0d2FyZSBmcmVlcyB1cCBFdmVudCBCdWZmZXIgc3BhY2UsDQo+ID4gPiA+ID4gdGhlIHF1ZXVl
ZCB1cCBldmVudHMgYXJlIHdyaXR0ZW4gb3V0IGFuZCB0aGUgVVNCIHJldHVybnMgdG8gbm9ybWFs
DQo+ID4gPiA+ID4gb3BlcmF0aW9uIg0KPiA+ID4gPiA+IA0KPiA+ID4gPiA+IEkgZGlkbid0IHNl
ZSBhbnkgb3ZlcmZsb3cgZXZlbnQgaW4gdGhlIGV2ZW50IGJ1ZmZlciBhZnRlciBwYXJzaW5nDQo+
ID4gPiA+ID4gY3Jhc2ggZHVtcC4gQWx0aG91Z2ggdGhpcyBjb3VsZCBiZSBzb21lIEhXIGlzc3Vl
LCBJIHRob3VnaHQgd2UgY2FuDQo+ID4gPiA+ID4gaW5jbHVkZSB0aGlzIGZpeCBpbiBzb2Z0d2Fy
ZSBhcyB3ZWxsIHRvIGF2b2lkIHN1Y2ggc2NlbmFyaW8uDQo+ID4gPiA+ID4gDQo+ID4gPiA+IA0K
PiA+ID4gPiBXaGF0J3MgdGhlIEdFVk5UU0laIGF0IHRoZSBwb2ludCBvZiB0aGUgY3Jhc2g/IFRo
YXQncyB3aGVyZSB0aGUgZHJpdmVyDQo+ID4gPiA+IHRlbGxzIHRoZSBjb250cm9sbGVyIGhvdyBt
dWNoIGl0IGFsbG9jYXRlZCBmb3IgdGhlIGV2ZW50IGJ1ZmZlci4NCj4gPiA+ID4gDQo+ID4gPiA+
IENoZWNrIHRvIG1ha2Ugc3VyZSB0aGF0IGl0IHdhc24ndCByZXNldCBkdXJpbmcgb3BlcmF0aW9u
IChub3QgY2xlYW51cCkuDQo+ID4gPiANCj4gPiA+IA0KPiA+ID4gSGkgVGhpbmgsDQo+ID4gPiAN
Cj4gPiA+ICAgVGhlIGxhc3QgMyBSVyB0cmFjZXMgd2VyZSBhcyBmb2xsb3dzOg0KPiA+ID4gDQo+
ID4gPiA8aWRsZT4tMMKgwqDCoCBbMDAxXcKgwqAgNTgzNC40NzE2NDA6wqAgZHdjM193cml0ZWzC
oMKgIGJhc2U9MHhmZmZmZmZjMDA5MWRjMDAwDQo+ID4gPiBvZmZzZXQ9NTAxODTCoCB2YWx1ZT00
MDk2DQo+ID4gPiA8aWRsZT4tMMKgwqDCoCBbMDAxXcKgwqAgNTgzNC40NzE3OTk6wqAgZHdjM19y
ZWFkbMKgwqAgYmFzZT0weGZmZmZmZmMwMDkxZGMwMDANCj4gPiA+IG9mZnNldD01MDE4OMKgIHZh
bHVlPTYzNDg4DQo+ID4gPiA8aWRsZT4tMMKgwqDCoCBbMDAxXcKgwqAgNTgzNC40NzE4MDM6wqAg
ZHdjM193cml0ZWzCoMKgIGJhc2U9MHhmZmZmZmZjMDA5MWRjMDAwDQo+ID4gPiBvZmZzZXQ9NTAx
ODTCoCB2YWx1ZT0yMTQ3NDg3NzQ0DQo+ID4gPiANCj4gPiA+IFRoZSBmaXJzdCBvbmUgd2FzIGF0
IHRoZSBlbmQgb2YgcHJldmlvdXMgcHJvY2Vzc19ldmVudF9lbnRyeSBjYWxsIHdoZXJlIHdlDQo+
ID4gPiB1bm1hc2tlZCB0aGUgaW50ZXJydXB0Lg0KPiA+ID4gDQo+ID4gPiBUaGUgc2Vjb25kIG9u
ZSB3YXMgdGhlIHJlYWQgb2YgR0VWVENPVU5ULg0KPiA+ID4gDQo+ID4gPiBUaGUgdGhpcmQgb25l
IHdhcyB3aGVyZSB3ZSB3cm90ZSAzMXN0IGJpdCBvZiB0aGUgR0VWVFNJWiByZWdpc3RlciB0byBt
YXNrDQo+ID4gPiBpbnRlcnJ1cHQgYWxvbmcgd2l0aCA0MDk2IGJ5dGVzIHRvIFsxNTowXSBiaXRz
Lg0KPiA+ID4gDQo+ID4gPiBUaGVyZSBpcyBvbmx5IDEwMC0xNTB1cyBnYXAgYmV0d2VlbiBlYWNo
IG9mIHRoZXNlIHJlYWQgd3JpdGVzIGFuZCBpZiB5b3UgYXJlDQo+ID4gPiByZWZlcnJpbmcgdG8g
d2hldGhlciB0aGUgR0VWVFNJWiBnb3QgbW9kaWZpZWQgaW4gYmV0d2VlbiwgSSBhbSBub3Qgc3Vy
ZSBvZg0KPiA+ID4gdGhhdC4NCj4gPiA+IA0KPiA+IA0KPiA+IFRoZSByZWFkIGZyb20gR0VWTlRD
T1VOVCBsb29rcyBjb3JydXB0ZWQuIFdoZW4gd2FzIHRoZSBsYXN0IHRpbWUgKGRlbHRhDQo+ID4g
dGltZSkgYW4gZXZlbnQgd2FzIGhhbmRsZWQgcHJpb3IgdG8gdGhlIGZhaWx1cmU/IElmIGl0J3Mg
YSBzaG9ydCBkZWx0YSwNCj4gPiBpdCBmdXJ0aGVyIGluZGljYXRlcyB0aGF0IHdoYXRldmVyIHRo
ZSB2YWx1ZSByZXR1cm5lZCBpcyBpbnZhbGlkLg0KPiA+IA0KPiA+IFNvLCBzZXR0aW5nIGNvdW50
ID0gZXZ0LT5sZW5ndGggaWYgY291bnQgPiBldnQtPmxlbmd0aCBpcyBubyBnb29kLiBUaGUNCj4g
PiBldmVudCBjb3VudCBpcyBwcm9iYWJseSBtdWNoIGxvd2VyIGFuZCB5b3UgbWF5IGVuZCB1cCBy
ZWFkaW5nIHN0YWxlDQo+ID4gZXZlbnRzLg0KPiA+IA0KPiA+IEl0J3Mgb2RkIHRoYXQgd2UgYXJl
IG9ubHkgYWJsZSB0byBzZWUgdGhpcyBpc3N1ZSBub3cuIEZvciB0aGlzIHR5cGUgb2YNCj4gPiBm
YWlsdXJlLCBpdCBzaG91bGQndmUgYmVlbiBleHBvc2VkIG11Y2ggZWFybHkgb24uIElzIHRoZXJl
IHBvdGVudGlhbGx5DQo+ID4gc29tZXRoaW5nIGRpZmZlcmVudCBmb3IgeW91ciBzZXR1cC9jb25m
aWd1cmF0aW9uIHRoYXQgbWF5IGNhdXNlIHRoaXMNCj4gPiBpc3N1ZS4gQWxzbywgaG93IGVhc2ls
eSBhcmUgeW91IGFibGUgdG8gcmVwcm9kdWNlIHRoaXMuIERpZCB5b3UgdHJ5IHRvDQo+ID4gcmUt
cmVhZCB0aGUgR0VWTlRDT1VOVCBtdWx0aXBsZSB0aW1lcyB3aGVuIHRoaXMgaGFwcGVucyB0byBz
ZWUgaWYgdGhlDQo+ID4gdmFsdWUgY2hhbmdlcyBkcmFtYXRpY2FsbHk/DQo+ID4gDQo+IA0KPiBU
aGUgcHJldmlvdXMgZXZlbnQgcHJvY2Vzc2VkIHdhcyBqdXN0IGJlZm9yZSB0aGlzIGludGVycnVw
dCBjYW1lIGluIHdoaWNoDQo+IHRvbyB3YXMgaGF2aW5nIGEgaHVnZSBHRVZUQ09VTlQgYnV0IG5v
dCBiaWcgdG8gY3Jhc2ggdGhlIGRldmljZSAoaW4gbWVtY3B5KS4NCj4gQW5kIHZlcnkgc29vbiwg
YWZ0ZXIgaXQgd2FzIHByb2Nlc3NlZCwgdGhpcyBjdXJyZW50IGludGVycnVwdCBjYW1lIGluLg0K
PiANCj4gKFRoYXQgaXMgd2h5IGluIHRoZSBjb21tZW50IHNlY3Rpb24gb2YgdGhlIHBhdGNoLCBJ
IG1lbnRpb25lZCB0aGF0IHRoaXMNCj4gY291bGQgYmUgYSBodyBpc3N1ZSB0b28gdGhhdCBjYW1l
IHVwIHJhbmRvbWx5LiBCdXQgd2FudGVkIHRvIGNoZWNrIGlmIHRoaXMNCj4gY2FzZSBpcyBzb21l
dGhpbmcgdGhhdCBjYW4gYmUgY29uc2lkZXJlZCBmb3IgZml4aW5nLikNCj4gDQo+IEFuZCB0aGVy
ZSBoYXMgYmVlbiBvbmx5IG9uZSBpbnN0YW5jZSByZXBvcnRlZCBzbyBmYXIgb24gYSB0YXJnZXQg
d2hpY2ggaGFzDQo+IHZlcnkgbGVzcyBjb21wdXRhdGlvbmFsIGNhcGFiaWxpdHkgYW5kIGhhcyBh
IGh1ZyBzdyBzdGFjayAoYXBhcnQgZnJvbSBsaW51eCkNCj4gcnVubmluZyBvbiB0b3Agb2YgaXQu
DQo+IA0KDQpUaGlzIHNlZW1zIHRvIGJlIGEgaHcgaXNzdWUuIFdlIGNhbiBhZGQgYSBjaGVjayBp
ZiB0aGUgZXZlbnQgY291bnQgaXMNCmJleW9uZCBldnQtPmxlbmd0aCwgdGhlbiBpZ25vcmUgdGhl
IGludGVycnVwdCBhbmQgcHJpbnQgYW4gZXJyb3IgdG8NCnByZXZlbnQgdGhlIGludmFsaWQgbWVt
b3J5IGFjY2Vzcy4gV2UncmUgbm90IHN1cmUgdGhlIGV2ZW50cyBhcmUgdmFsaWQNCmF0IHRoaXMg
cG9pbnQuDQoNCkFzIGZvciB0aGUgcmVjb3ZlcnkgZnJvbSB0aGlzIGlzc3VlLCB3ZSBuZWVkIHJv
b3QgY2F1c2UgdGhlIHByb2JsZW0gdG8NCnByb3ZpZGUgYW4gYXBwcm9wcmlhdGUgZml4Lg0KDQpU
aGFua3MsDQpUaGluaA==
