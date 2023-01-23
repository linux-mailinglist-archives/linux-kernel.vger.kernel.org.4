Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09A14678669
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 20:33:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231691AbjAWTdn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 14:33:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230236AbjAWTdk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 14:33:40 -0500
Received: from mx0a-00230701.pphosted.com (mx0a-00230701.pphosted.com [148.163.156.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19E5D30E90;
        Mon, 23 Jan 2023 11:33:40 -0800 (PST)
Received: from pps.filterd (m0098571.ppops.net [127.0.0.1])
        by mx0a-00230701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30NJHEgS015915;
        Mon, 23 Jan 2023 11:33:26 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=pfptdkimsnps;
 bh=KoQGfzDv3kL/3TrCA4nBPF336CJ9xRTA6GWsbOUaRfA=;
 b=Ac2TymJ2pjKssTrap7dtOt2ALM+P7Y5oQYFLIpYJFrJ1VWXkocq4XTqNdJ/yPcHSnXe7
 tIDcAc9Qrg8qkXB05naCBdmyK5ZXyNfZy8o1N5MH6aW7yP7RAfp0S6skFWBbHAy8QVLt
 6FfCVxUTGL3YutxWllqaNDuq/ExyvSSEbstobF6P8CuizNRjMimyNV+F2nAw8RlZwtGM
 DT3p0mrWBaOnb1D5TnLk+mDV9NRJ6nI5XLopXG8+C3PBAM8KcoWGtbdPj5d9ESVdKFhe
 3O5k6mdDhYmxkIV807y2UPVJa8QDYwkyhwbHeFxxf1e2aY+sddePeHSGTuZ1URmKjlph 7g== 
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.87.133])
        by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 3n8fxrg5g7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 23 Jan 2023 11:33:25 -0800
Received: from mailhost.synopsys.com (sv1-mailhost1.synopsys.com [10.205.2.131])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 302ADC0102;
        Mon, 23 Jan 2023 19:33:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1674502405; bh=KoQGfzDv3kL/3TrCA4nBPF336CJ9xRTA6GWsbOUaRfA=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=DYut+GTPlKK9CW8lMLwM+mjasFvPD37MRZhdNkprIv8tQFpzOvAPrG7UIj/Ow358x
         lzw5cCeG0QSIQhWCeqfDTaHRYdBKdpDa4RQnWjEqPigEkvSBVAnIAoRu0NeDf4ymBj
         8Z81gvQFW++XXNi13G75vrmSsnZQ9+2ywpce+6Jq8R6SqR15SGKXoWGSl3LEjPBwAy
         LAQj/R95sPlhxgyFjZ7GsndW/ziSNGdO7R+T/LqFm3pugNgwHwGeEAF8cgCaFQksUF
         QG0MsFn0KuKO6fEktT7UGqktSy4G0qff2KoCth8HBIWA8crLUncBU0s1BYj2utk8KL
         6lLVKqDoonFKg==
Received: from o365relay-in.synopsys.com (sv2-o365relay3.synopsys.com [10.202.1.139])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
        by mailhost.synopsys.com (Postfix) with ESMTPS id 6A6BEA005C;
        Mon, 23 Jan 2023 19:33:24 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2177.outbound.protection.outlook.com [104.47.59.177])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id CC36B40119;
        Mon, 23 Jan 2023 19:33:23 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=thinhn@synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.b="QATuzyFz";
        dkim-atps=neutral
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gOsS6hFF6ypFpUyOeg+cgU1d24hxJ44RiMZ60VbaXr3MfafuZlBei5GrbJGPLeidxD929rFz+9gpHM90k0gelknKZC1B6XxrtmoTpFW4wqofrFLRignR+UPs409q3intT1/9D0EljegaU58sIsXM3cnZ0gfpptpmKx4GjlxJ8dlkzCZawJxjn2xiy8recByfpj+HndUD6Ze6J6QMNKAJRDD9+dPUpdPeowhk53jKnABjNrTipG9IuVWx+M0N71iH+0W3qaznQmNaq5498oqmdgjaKinpPf2HgQzBcgqTk8wrknsYf7C/L9z497EZrc3c+1GISbLrD4Numomm2Zdv3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KoQGfzDv3kL/3TrCA4nBPF336CJ9xRTA6GWsbOUaRfA=;
 b=AkBIzuK+VuCEaJMb4b44fbOhOBCg3xMCvw+5HT85XVqaZrWa/M2OpAZ3Un3Z/qn1N7KHYn2VNij5IqwzGpFjuxspNdUmPV5QAOKq/icHkLy2bd8nJXy+eNaVqz5A+g/E8Y/W7Qg05gzMgrUZjYasyQO5iIsSOtcNTT/p/dwj+NL/SLt4+sHOnxDxBOb8gcULB25n8imNcpdfKMMLp9kI8KF6F4F5Czi/mTnhw6AdQUWZJGy4zX3JLQi9ACNQ/xLtsGcYNKG/OSIkhpVc9GVwHQEDroshBlTpVZDc/1SQXS4vWxtMQ0fgBcX+TKaNhV48u3to6qKhAWEyoTH7qL5apQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KoQGfzDv3kL/3TrCA4nBPF336CJ9xRTA6GWsbOUaRfA=;
 b=QATuzyFzw7BhnSubBFJBTD9k1qqnk4VEThILEJk9uxInBGoRPPu2ikfNN7v5nK7AnDifvJiIJWEilyl06wpOir2Zji+LhCfgygPfnqoWIpyHVwNkBebIvaOlSSx4h/+PuYDgONUuHhyAVL1AdTjNYYKNGycKc3HjIZWgb9vjGYg=
Received: from BYAPR12MB4791.namprd12.prod.outlook.com (2603:10b6:a03:10a::12)
 by BY5PR12MB4210.namprd12.prod.outlook.com (2603:10b6:a03:203::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.33; Mon, 23 Jan
 2023 19:33:20 +0000
Received: from BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::6f3c:bd8e:8461:c28c]) by BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::6f3c:bd8e:8461:c28c%7]) with mapi id 15.20.6002.033; Mon, 23 Jan 2023
 19:33:20 +0000
X-SNPS-Relay: synopsys.com
From:   Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To:     Alan Stern <stern@rowland.harvard.edu>
CC:     Elson Serrao <quic_eserrao@quicinc.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "balbi@kernel.org" <balbi@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "quic_wcheng@quicinc.com" <quic_wcheng@quicinc.com>,
        "quic_jackp@quicinc.com" <quic_jackp@quicinc.com>
Subject: Re: [PATCH v2 1/5] usb: gadget: Add remote wakeup capable flag
Thread-Topic: [PATCH v2 1/5] usb: gadget: Add remote wakeup capable flag
Thread-Index: AQHZKr5r/qObzpub/UasYeFFzcErsq6k+Y6AgAF5HgCAABEigIABfykAgAAEBYCAABpUgIAAAgCAgAABMYCAAAGWgIAER4UA
Date:   Mon, 23 Jan 2023 19:33:20 +0000
Message-ID: <20230123193320.sxywht5vr3sig2ur@synopsys.com>
References: <1673992507-7823-2-git-send-email-quic_eserrao@quicinc.com>
 <20230119014409.yiw6xlp5cwlmu25s@synopsys.com>
 <f49c54d9-b9fe-e629-3f94-809cd79a2211@quicinc.com>
 <20230120011513.ajwum224lfwwb6ws@synopsys.com>
 <045f9ac1-5d48-fad0-8e74-8d5144aa1431@quicinc.com>
 <20230121002059.mpiqavemelnntxd7@synopsys.com>
 <Y8tGAXbKDtzmW8+E@rowland.harvard.edu>
 <20230121020223.l2tyvyqifc7umqpy@synopsys.com>
 <Y8tIrx+F/4X9YyFT@rowland.harvard.edu>
 <20230121021219.udgpwt7tv7dfr3jk@synopsys.com>
In-Reply-To: <20230121021219.udgpwt7tv7dfr3jk@synopsys.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR12MB4791:EE_|BY5PR12MB4210:EE_
x-ms-office365-filtering-correlation-id: 6c839e9b-a75e-4b85-72fe-08dafd78af4a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: V8/i6ezsqwIGvowVXGISGmV0XNIDDtuWOTbfPy7d/hPewSVb+CTP/tO+N/FRaSGbtD1QBsEhPLs3fiSaOcyoZBS5rspocGvwBkd+5dscFm4XgqyrxdP6NH0YJoXapN+jFvrIdL6/usmVT4PVgaGxHrFCvFcIzjzBxaLbmvmz3MxZGh3bSILTr1Yd3NUBZxtegOGVnf2wT/oYH1Xi76PnozaP4eixltV5wx6Kd6LtKJzfvwH+PtDq3KBi3SZugBeFNNFUNgO+HnfQif5dQrjABTrZpqcSr7yoJdlIZgePPOUhcb3M3Mdw3PcdxXiwNA5ke6FF3UROr842TrMT+x6eqmm6+IZGruaonLjaH0Wwh/EhxNwuHE9Mhd4To8E76N+i/ZDFX5fAEQgXyQ5Hg4TCZKO7zaTRuc9ZCyoltmx6ssSDJtA32okcr4579GWjXERxpHihait1WB7WTEpiFVpQqzL21DxzkDxxoRod3pSwwqMI7jTUFdwQHSd+q4uFFtgXx5cnkcjO3XW+ljG4+STq6lq8l6RB97EHijBg++QVVHHa68NyZBj5TtQrttfa/TPyKkNlWqrqefSrsp1THfggs/BbQL47H1YInXc9IVELPfi739LtVflymZkQUxkxRoPtewZvrCEzuS/ZbnZF/3w7KskiLq8QUfflTmMCdBESvqQYke00Ks4bEAbXktxzg05acCRyDl61YDjTlBK3u9W33A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4791.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(376002)(366004)(39850400004)(396003)(346002)(451199015)(66899015)(36756003)(86362001)(38070700005)(5660300002)(8936002)(4326008)(2906002)(41300700001)(83380400001)(122000001)(38100700002)(6486002)(71200400001)(478600001)(6916009)(26005)(186003)(6506007)(8676002)(6512007)(316002)(76116006)(66946007)(66556008)(66476007)(64756008)(54906003)(66446008)(2616005)(1076003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SFladUlmS0hNVnloWWhYb1V4MGVJYitVbEN4bE9RQ09ZV09kZThSdVVLNzg0?=
 =?utf-8?B?NjJSb0VyVnVxQXNmcFg5aXRueHNCODdYSExvZDMxbmszRTdrdllxYk5vZ09W?=
 =?utf-8?B?QS9qQjVxM3J2Y091a0VwYWlENjJOMkNQZmFrODBrbkZFNmQzY0I5TWE2TFdH?=
 =?utf-8?B?VHNGQlRsN242dUZjVXVCbzF2eW90K2hOUEhxZk1wVzZjVW5yaGdVQ0JrdlRR?=
 =?utf-8?B?TTNnV2N2Y04zYkQvaHJZQU5peGhIQVlSWk9rZUd2UnZwZ0l0RnJxQkZ3UnMr?=
 =?utf-8?B?SCtsYnZpUFBITUFEbHovdll3Yk9BZHdyZ21XeGZCQzF6dTgzRUpNWFNFQ3Zw?=
 =?utf-8?B?SDRpVGV6T3VhSXZicWp2bFBEbVVaTXRBMWg3MFN5Z2NuUmN0WnZyZ2ZTQlVz?=
 =?utf-8?B?WUVSSlhUU1I0MG94aTNFbnNvOXJjdDVpNzJNMy9oN0k2aTJOaUtUSlNiYURu?=
 =?utf-8?B?SEN5MVgvZjBQNUh1YVJLRGVBZWt3cFpFa01FMkJtQjVxMXVxNlloRHNRM0NT?=
 =?utf-8?B?Nmg4d1ljdmh5dTU2VG14NGhEWkJIaXZScGJlYzUvamdvcnhBcnNnZkNZRGNR?=
 =?utf-8?B?aEFUbGhySXVFd1h3TDVEbTFvRjAyVVo5dkFIMEozVjhDVE1COGZUamNlS3lm?=
 =?utf-8?B?TnRVSEcyTWlNWTFnNGk0K0toU2VKY3ZCQ3NxMzZvSys5d1RhbGJJRkV4RG5i?=
 =?utf-8?B?MVZ5ZkxMbmcyNzMxUERFdTJ3dlRtcU1XeE9TUzVOTWU4S0RNQnB6UUtGa0RB?=
 =?utf-8?B?WjY1R0xGb3FEQ1I0d0g2ME90QVYrUzJkNE5mbCtIdllXR202aUlTdE5ZR0xQ?=
 =?utf-8?B?VkNaUG5nZ08rdDV1Q1BNZFRGdWRENjRnd3NqcTBNVExlek9IeGowMTVzdWZI?=
 =?utf-8?B?VktzVUhZUW5TTDZiblB5OWErK0xhRk5uN1czUStsWDBHcVpSbGJxWjRzTkYz?=
 =?utf-8?B?V0QySlhkREtDakVFU1c2czVZUlFaMVhoVXBveEpGMjJxdkZiMnRQQURVRmht?=
 =?utf-8?B?RVVGYnQrWGkvRnlYeEIrYXRUQUVHOXR0S0NROFFjSlBmWmhlT21QaEdweEl4?=
 =?utf-8?B?cGRmWjJHd3NOSUJNL21WY1ZFOWxkMk9yRXMvWjAweVJLRjIyT1dHUnhTZ3lU?=
 =?utf-8?B?M3ByYUVvdXBnMGFmOUxITk45cmdORWV1ZlROalE2WWdSTU40eklBTmRTcWF2?=
 =?utf-8?B?OGJkTHlFTTAzck54MDlYei9qeFFSaU8yT043SjQrVEpGRG80REdWQk5uaXNx?=
 =?utf-8?B?K2FERkpzOEwya2N0YmtvU2xCRm91TUNydFpkbFYvck0wbVl6K2JSRmdTUnZp?=
 =?utf-8?B?Z1AzSG9sMHMwQldvaEM5ZzdGakNlSlYxbzUvRE42R3VDUWd6UHBML3NoRFFt?=
 =?utf-8?B?eERCRjFZd1FrNm43R21NU3hmd1BGUGVDallpdndNenJxUWVydk9WRGNYdnZB?=
 =?utf-8?B?YzZYV3h1ZUVmRGZQV3JudHMzYjNhaWJYQUJJei9GcFROMWN0ajVZdlkzV29Y?=
 =?utf-8?B?UEw0VzRIL1hnNHZTKzg1SFNSd2FqY0Q4bjFMeDlEaGlrQzZTc0lUOEc5Njhx?=
 =?utf-8?B?SlNrRzdwRHVBWnNHY1BjUE5sK21JalNVdFMzd2M1c0VnQTkxTE9nSnN5anM4?=
 =?utf-8?B?ZDVkZVl4TVBOV093SXp3dlJqTnhYa3ZqT0VBZmY3OHhLUit0OTR6K3ZiYmov?=
 =?utf-8?B?UHpnMVgzMkJqVTM3UkhvRTJhK2g5blhxR21DTVBhQkhBTmhNWkNNc0FwQmRa?=
 =?utf-8?B?T0xtT0pubXdwSUFhNy9wN1c4QTVUS0RRV2lyQVZ4T2ozbVVVNUtDc1NpKzZi?=
 =?utf-8?B?dHlpTllZbzBHc1ErUTRJMldxbGRrbEpaSUJRK2xWN1BiWDNFVnRMMXM2VmlU?=
 =?utf-8?B?bjcxYWw5eVVubzVFSURwVmdGVEsrZlE4bjV2SmllTFFIanFENjdMV1NxeHFW?=
 =?utf-8?B?bGxiaktOVHhMZEg1b3MyZzFWRnRCNDZmRHcram5YM0g3N2ZLaG8yeitZMlRn?=
 =?utf-8?B?cmdjVGVmNHN2bFpGVWR4bENBWFVUcTlaODJySm1sV2pJTkpKa1g3M1lQRHpZ?=
 =?utf-8?B?WnExU0p4bUVTU2tITU00ZXhzeU8wckRML1VsaGpmaVlHb3RaNVdWYVNMUGpD?=
 =?utf-8?B?aTdPbFNwaG5tSTJncDBzb1FtcDRpbUo2dnNlcGY5biswYU1tQTVoZWNZUWo5?=
 =?utf-8?B?amc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7F43FA811DF6D440A66869304D21C330@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?SjR0K0k4SlRBVEJzVTh5V3l3R2hVZFVRV1hSdVo3aFF3elVXZ1dzM1Z5VjZj?=
 =?utf-8?B?TlJSNlBYSDU3bVBpQWpMQUY4WU4zcDZqazNxQlRJNFVORlNYM3dlUXladUY1?=
 =?utf-8?B?Q2JXU0JMTkJlQ0dYdENSbHdoZExxeDNkQU02NkdXVDUvQXVJWnoybWFRWG9w?=
 =?utf-8?B?TFpjUHI4dzgxU0U2RmJObDBxdC9FazdQN1k0VEUzZVcyQ3dlTk9hRnlkWGw0?=
 =?utf-8?B?WWtaQzQrZjZxQWJsT3pGN0dmNFBwdHkvM0pZeEkvd1VtVjN6Q3dkeXZabVpk?=
 =?utf-8?B?NTNlSW50SlpBTWxZYTRFZmNma29TejFObHcyUzM4MzZCbnFSYnl5dDZXNktJ?=
 =?utf-8?B?eW55UVFNTmNXd0pxMjFCNEN0Y2U5NEpMU1o3N0hRSUw4anlSNlFXVlJwejRo?=
 =?utf-8?B?VWFlQjl1N3V0eGRIWWFjdDVQcW82dEFCTnhUWGFXN1hMY241dUtiRGdOb2ZH?=
 =?utf-8?B?eUZXTWpjOHkyVFJZN0duVHpnWGhRWGZXSnQzM1ZKcExXZG40YU5zU25NUUho?=
 =?utf-8?B?UzZJeklpbUpVbUpxaXhIakRGdXk4ak8zT2VwSVBnc20vQkJGME5GSXBNR3c0?=
 =?utf-8?B?S3dKcEtJdzlxQkNoMWJzT0UzdllwT1lJN1hUK24yQTFGMWxjVmR2WFhOOFQr?=
 =?utf-8?B?OVQ1RXREYmMzdVVFR09hRE9UTHVqMU1wRVllNEZjaFN4SUQyY2w0THdyaXQy?=
 =?utf-8?B?TmQ0em8yYnk5cDE2akF6ZTZsMUozQk1BQXpLQXp2d2xUcHp3a2JhcXA4clc2?=
 =?utf-8?B?aGRQN0RpaHc2aDVmTWZnUWFxSytteC9NTHpWOGtib0RZbjdMM01SWjJSMFpT?=
 =?utf-8?B?d3ZzNEtheFppTkwvcGE5MFhXRE5wc2x2bGNMUCtqZWp2eTVyT3dSZlFzVFQ1?=
 =?utf-8?B?b05LdjdKQVA5dVVEcVFTSitHZzRZd0t0a3R5TlNzeGhvTjJYay81NG9HVGxK?=
 =?utf-8?B?eHpJKzljdUhjd3RtRmx0MlAvd2xCTnhoRGdqK3Arbk4zM28rSmZmSm10QlBr?=
 =?utf-8?B?YnVOOStTRUxJbER0Q1JYNk9HZW8rVFlDdzdaL0ovSEc5bmEvYXJFYzB3YWVM?=
 =?utf-8?B?bzE2RzhsQXlRWHo2L1JBYXRpdUc2TG03YWxIMTNvbVBPT1hpbkhxUXd6bVdq?=
 =?utf-8?B?OWMxMFI0RmZ5YnFQa3RPQ3RTL0hhVEtVblJiOHZ4QVZoWTFsV0dkUUdlRm9i?=
 =?utf-8?B?ZkJMeFhocmk4NnEySnFFWWY2bTIycXFhVFdOM1dMTzFLakZCZ2dhUWR4ektp?=
 =?utf-8?B?TnM4RW4vQm5MbEpPYmoyb3l2ZnhXUW5rOEJiTzczSUhpbEhDUT09?=
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4791.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c839e9b-a75e-4b85-72fe-08dafd78af4a
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jan 2023 19:33:20.4828
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6vxrdEyeSb4If6hl9sOwkE90/asSMr+fOqq4aegaPc3onoLkFL8ikQMkPmm9hQ+JQWYDrn4cNS8aDIRZaVC1SA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4210
X-Proofpoint-GUID: OeFyBA3hI1sZLr8sEtc29w2uggYtPpzA
X-Proofpoint-ORIG-GUID: OeFyBA3hI1sZLr8sEtc29w2uggYtPpzA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-23_12,2023-01-23_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 bulkscore=0 phishscore=0 malwarescore=0 impostorscore=0 suspectscore=0
 mlxlogscore=811 spamscore=0 priorityscore=1501 adultscore=0
 lowpriorityscore=0 clxscore=1015 mlxscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2301230188
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gU2F0LCBKYW4gMjEsIDIwMjMsIFRoaW5oIE5ndXllbiB3cm90ZToNCj4gT24gRnJpLCBKYW4g
MjAsIDIwMjMsIEFsYW4gU3Rlcm4gd3JvdGU6DQo+ID4gT24gU2F0LCBKYW4gMjEsIDIwMjMgYXQg
MDI6MDI6MzZBTSArMDAwMCwgVGhpbmggTmd1eWVuIHdyb3RlOg0KPiA+ID4gT24gRnJpLCBKYW4g
MjAsIDIwMjMsIEFsYW4gU3Rlcm4gd3JvdGU6DQo+ID4gPiA+IEEgVURDIGRlc2lnbiBtaWdodCBo
YXZlIG11bHRpcGxlIHZlcnNpb25zLCBzb21lIHN1cHBvcnRpbmcgcmVtb3RlIHdha2V1cCANCj4g
PiA+ID4gYW5kIG90aGVycyBub3QuICBCdXQgZHJpdmVycyBnZW5lcmFsbHkgdXNlIGEgc2luZ2xl
IHN0YXRpYyANCj4gPiA+ID4gdXNiX2dhZGdldF9vcHMgc3RydWN0dXJlLCBhbmQgdGhleSBkb24n
dCBtb2RpZnkgaXQgYXQgcnVudGltZSB0byBhY2NvdW50IA0KPiA+ID4gPiBmb3IgaGFyZHdhcmUg
ZGlmZmVyZW5jZXMuICBTbyBpZiBhIHNpbmdsZSBkcml2ZXIgY29udHJvbHMgdGhvc2UgbXVsdGlw
bGUgDQo+ID4gPiA+IHZlcnNpb25zLCB5b3UgY2FuJ3QgcmVseSBvbiB0aGUgcHJlc2VuY2Ugb2Yg
Z2FkZ2V0LT5vcHMtPndha2V1cCB0byANCj4gPiA+ID4gaW5kaWNhdGUgd2hldGhlciB0aGVyZSBh
Y3R1YWxseSBpcyBoYXJkd2FyZSByZW1vdGUgd2FrZXVwIHN1cHBvcnQuDQo+ID4gPiA+IA0KPiA+
ID4gPiBJZGVhbGx5LCB0aGUgdXNiX2dhZGdldCBzdHJ1Y3R1cmUgc2hvdWxkIGhhdmUgYSB3YWtl
dXBfY2FwYWJsZSBmbGFnIA0KPiA+ID4gPiB3aGljaCB0aGUgVURDIGRyaXZlciB3b3VsZCBzZXQg
YXBwcm9wcmlhdGVseSAocHJvYmFibHkgZHVyaW5nIGl0cyBwcm9iZSANCj4gPiA+ID4gcm91dGlu
ZSkuDQo+ID4gPiA+IA0KPiA+ID4gDQo+ID4gPiBJIHdhcyB0aGlua2luZyB0aGF0IGl0IGNhbiBi
ZSBoYW5kbGVkIGJ5IHRoZQ0KPiA+ID4gdXNiX2dhZGdldF9lbmFibGVfcmVtb3RlX3dha2V1cCgp
IHNvIHdlIGNhbiBkbyBhd2F5IHdpdGggdGhlDQo+ID4gPiB3YWtldXBfY2FwYWJsZSBmbGFnLg0K
PiA+IA0KPiA+IHVzYl9nYWRnZXRfZW5hYmxlX3JlbW90ZV93YWtldXAoKSBnZXRzIGNhbGxlZCB3
aGVuIHRoZSBnYWRnZXQgb3IgDQo+ID4gZnVuY3Rpb24gaXMgc3VzcGVuZGVkLCByaWdodD8gIEJ1
dCBhIGdhZGdldCBkcml2ZXIgbWF5IHdhbnQgdG8ga25vdyBsb25nIA0KPiA+IGJlZm9yZSB0aGF0
IHdoZXRoZXIgdGhlIFVEQyBzdXBwb3J0cyByZW1vdGUgd2FrZXVwLCBpbiBvcmRlciB0byBzZXQg
dXAgDQo+ID4gaXRzIGNvbmZpZyBkZXNjcmlwdG9yIGNvcnJlY3RseS4NCj4gPiANCj4gDQo+IE5v
LCB0aGlzIGlzIHRvIGJlIGNhbGxlZCBkdXJpbmcgc2V0IGNvbmZpZ3VyYXRpb24uIElmIHRoZSBj
b25maWd1cmF0aW9uDQo+IGRvZXNuJ3Qgc3VwcG9ydCByZW1vdGUgd2FrZXVwLCB0aGUgZGV2aWNl
IHNob3VsZCBub3QgYmUgYWJsZSB0byBzZW5kDQo+IHJlbW90ZSB3YWtldXAuDQo+IA0KDQpPbiBz
ZWNvbmQgdGhvdWdodCwgeW91J3JlIHJpZ2h0IGFib3V0IHRoZSBkZXNjcmlwdG9yLiBJdCdzIGJl
dHRlciB0bw0Kd2FybiBhbmQgcHJldmVudCB0aGUgcmVtb3RlIHdha2V1cCBiaXQgZnJvbSBiZWlu
ZyBzZXQgaW4gdGhlIGRlc2NyaXB0b3INCmlmIHRoZSBVREMgZG9lc24ndCBzdXBwb3J0IHJlbW90
ZSB3YWtldXAuIFdhcm5pbmcgdGhlIHVzZXIgYXQgc2V0DQpjb25maWd1cmF0aW9uIGlzIHRvbyBs
YXRlLg0KDQpTbywgd2UgbmVlZCBib3RoIHJ3X2NhcGFibGUgZmxhZyBhbmQgdXNiX2dhZGdldF9l
bmFibGVfcmVtb3RlX3dha2V1cCgpLg0KDQpUaGFua3MsDQpUaGluaA==
