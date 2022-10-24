Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B8B860992A
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 06:33:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229800AbiJXEdF convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 24 Oct 2022 00:33:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbiJXEdA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 00:33:00 -0400
Received: from mo-csw.securemx.jp (mo-csw1114.securemx.jp [210.130.202.156])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19527753BA;
        Sun, 23 Oct 2022 21:32:58 -0700 (PDT)
Received: by mo-csw.securemx.jp (mx-mo-csw1114) id 29O4WX1D015399; Mon, 24 Oct 2022 13:32:33 +0900
X-Iguazu-Qid: 2wGrYy8wQgAWV0xULn
X-Iguazu-QSIG: v=2; s=0; t=1666585952; q=2wGrYy8wQgAWV0xULn; m=DPW8j72U1WrcwvAABj0KbT39wzyWneK7jEIjY+M50uQ=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
        by relay.securemx.jp (mx-mr1110) id 29O4WVOb032413
        (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 24 Oct 2022 13:32:32 +0900
X-SA-MID: 48169620
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bt0D4ArB2oWZkMRvHgBVqd+mQxczJXV47nJyC5TCq3Xp3HsXdRicQtejOzqNdAhcCtYrSeH1xQpIsa9/mSe6+GFsuC73YOBFm6Y6ekcYpowL9Ww198V53JTJxHpDnREcTH5amhuceO9No04ivnz/QcmU0i90ft4Sdfa/OhyEnpXEDVPw4oylVW7dyUq9bCAvRe5gl1q2s7UxdEhUfZeaNgfeueK/v9vIZUdH39Ki57b9jHeSy/0O3EtLaYCUdKZRK1+hRxRaSfL7X1f1f7SLzkYbkhdQvZR70ipEz6lpsePOX31F/MoC79gSRypwblu+4XN/G7ZYQlHOGtKbGho3ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bttP4DE0dD3pEtZbVmzWHkdWrRMY6dCs7ozusx2pzxc=;
 b=YMzUa7SgM+wbcOeHrkwgEqJrbV8iR2sdeEkTZ4QYY2jfQ/EMzIiTF8eVyntwnP9Qh10oqinWcXvAGt6FFs0wI3ryOQPDkyn44H7xRcjb2bldkjA1UZg1clEy9ak5RrPe2DGgWwNcr1e7mRgej4JLbsoTh9TkpYfLrJVbDj4WcGwM1nGC0P3NA8/fL9A0mswDuBY3rWKXHjVHXDWr/woqce4cJn7fjwuapNctnqb9oXDTcpb8kuhxNX5GbcrpiDsuISrO2Q53PbLEmEbLdV+PZCnFIlGBIUe09FAFu5EN0BLek7zVctoZpYS5id6ie0QaPmGUiZJauDzRfmQXEK9Iqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From:   <yuji2.ishikawa@toshiba.co.jp>
To:     <posciak@chromium.org>, <paul.kocialkowski@bootlin.com>,
        <hverkuil-cisco@xs4all.nl>, <mchehab+samsung@kernel.org>,
        <linux-media@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Question for an accepted patch: use of DMA-BUF based videobuf2
 capture buffer with no-HW-cache-coherent HW
Thread-Topic: Question for an accepted patch: use of DMA-BUF based videobuf2
 capture buffer with no-HW-cache-coherent HW
Thread-Index: AdjnYKQwg5kJk8s9S/Cvff5NBTRsiQ==
Date:   Mon, 24 Oct 2022 04:27:26 +0000
X-TSB-HOP2: ON
Message-ID: <TYAPR01MB6201716571D23E09CC436555922E9@TYAPR01MB6201.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYAPR01MB6201:EE_|OS3PR01MB5992:EE_
x-ms-office365-filtering-correlation-id: 90ed0f6b-9488-4212-51d5-08dab5780e06
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tr7ztXMHUPLUIBFlCU493PVBKIQW4n2TeEPT9goodtwNbUZ54hy64IaFCHRVq/DUt4YTPr2JCi/zu/4JGFULGpgOYhUSZisunGgcyxFjprRi3kAXUCqDsHDTaGJ4bVAq+qP2sPMcgp2W8peTzXMGy6uKwIsgFPPNOzZyrx5ja5UEja7ZxrcbiC6y7eclxD1ahSiooTAYgJqn/sTKalTMdsFuQughJj1y1wH2HLkomO56gQImLKy872eVcA+ZLn6icGZtlpV5IIaJF7hlV//Xp7fHxzUrJkeAfy8BuExO9nB9FF3J4O0W42zEyBTBX16UFRPSEUY4TMuZcWx9HtGn0DjxXZyGXdDYlH6RyQuiklVwuvs0drzNaEYkaMmdIJQvVdEvamEm1MnNxPGkNjMZ0QdWLLWrmZuyAqB+TwrmyhdnPZi5jF/op2uYwtywsMXGmzrWqwj7r3CK4Tzpi9DQ5obJeu/90e/V7y7wJ1km6VfuNRqdplNPzs2ONWLJl90oEwIJ+IdouQglJH4nn2rStAuTF1rLEfQOCb5a8RBcAEv+YEvd96TEoVf+FSFBNiOqdovSPb6X5fHrMDx9/BtCNKSMxEQIZ9wPGOrjHUOK2Mhgur50IP9bXdk6VpgnhjurF7j6XKllDHPBjBBtGOIQZsL0TKuzP5u7a76fbsJ7hS9a9PEHBs8o7QqsKgn4BJ8hJnbfgR13+dc6E++623IjctpeVvoLwQaw9z+V/bJ0X99CCVzs7rDSBVPCuvusrxW6XYldqiy9V0QgYDvzdUhoYHjrt3buiT0wqrf/DveDvaw=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYAPR01MB6201.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(396003)(136003)(376002)(346002)(366004)(451199015)(186003)(83380400001)(38070700005)(5660300002)(86362001)(38100700002)(2906002)(122000001)(52536014)(8936002)(41300700001)(55016003)(478600001)(966005)(9686003)(71200400001)(26005)(76116006)(6506007)(316002)(66446008)(66476007)(66556008)(66946007)(8676002)(110136005)(64756008)(7696005)(33656002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-2022-jp?B?TXRCSGNpaEducHUxcVpaTVBvTHZZRFdYZWUyRGMzbVVQSDM3OUF0N3lN?=
 =?iso-2022-jp?B?RXc0eEE0dDBrNWFoZHVhYUs5aS9LcFZPb25EQ1NvYXQ4MVZoQjRycFBj?=
 =?iso-2022-jp?B?dWs4dFJoMTRGSU1zNHhRTFdYYU4xMGRRNzlmbi9LUE9ucURSTzRpSFJB?=
 =?iso-2022-jp?B?Rk42bmNPVVBOQ2RrMnk2ZUpnSGorYlVOOTRYbGtaaERaZ29YeS8yZ25E?=
 =?iso-2022-jp?B?ZmdEYjlQZDlsM25ab0ZuSzhGNU5sZmFMRlord1Y2aGlxVWFvdEZ5MU1I?=
 =?iso-2022-jp?B?M08xeVlNZGFsLzc3amlqQWlzWGhFaW84Vy82S29LZ2xvY28xS3J3MFRl?=
 =?iso-2022-jp?B?SFNrNHYxZFJrQ3JDS0N2RmZIOXZaMXVqdnJnOGtLcktpWSsxYzJuakZr?=
 =?iso-2022-jp?B?QlNRTVdHYmlCWDRjekhMbFRJSGRWOU1QcWZRUEdaYVYwR25HT1pHd0Ix?=
 =?iso-2022-jp?B?Mm5KcnVjR2xFSkdBMS81NHZrTjZsSTBORjBNQks5YUdIUEV1UVBvaE5N?=
 =?iso-2022-jp?B?dU4rUmVnL0g2R29KNTFlWGh5dFZRV1pqaVNOSElKb1h2SkdCV3FzRllS?=
 =?iso-2022-jp?B?bkFwTm96M0E5Zzl6UVVUc0g3aklGVjhzQm9lcm1LclJPVk83eDJ5Y0tC?=
 =?iso-2022-jp?B?bmZsVEtyYlRpdmpERGNwTHN0S2o3bjNCSUltRHdQNnkwM0taQ1lKRTEx?=
 =?iso-2022-jp?B?VW0vMTlLQXJ5UFZOMzR1VUtVT1pIZkN3TlVxUVVGSEpzUmppczhlcDRw?=
 =?iso-2022-jp?B?ZmZ5eFdhQ1F3Qkdsb0I3S0pDQnJnTEZHY1UwZzJ3UGltdGpDem9tSFda?=
 =?iso-2022-jp?B?dWUyNW1ueWEvUWpNUUJHcmpLV2tmc1JDSFdSdXQwZWJzbzBmT0dwdHlW?=
 =?iso-2022-jp?B?WDd6RXhkVldEMktLV0hkVmhUN3E5VjZqN1prY1RFUmViVE41dnRiZEl1?=
 =?iso-2022-jp?B?U2hVU2xlMk1KZk1VN3lrWFBCQVZ0Y29NWWw1NXdiZStUR1ViM1VsbjFk?=
 =?iso-2022-jp?B?R3oveFRSQW1nTVc4SlpGWXBYSzM1ODd2QUY0T3VpL3R2T05NN0M1Ukto?=
 =?iso-2022-jp?B?b3o3MUQ1bFBCQTNTczBLOWRxWUczZFZVL2xRU3g2d01oRGt6OWtUZFNv?=
 =?iso-2022-jp?B?aW9kRndUWTJxV1d6cFViS3dXOFpFK2h5am03c1lJZU9SSzkzckxsWDNL?=
 =?iso-2022-jp?B?bWJ1dndiZUVNL2xYRmdpUXNGZTJjN3I5SUwvZDBZcGJJQ0J1T1Vpc0xz?=
 =?iso-2022-jp?B?dzVLeExCL1lSRmNIYjd0RmFIaXJjbGc0YVowMWdBVEVaellhNkowamRK?=
 =?iso-2022-jp?B?TU5WaUk0M3RGUlh2UW1rS3lMTzY0NlJWNzNmUkd2VjZqOVhrZ1lFZGJt?=
 =?iso-2022-jp?B?MmFick4wMjNjVG91QU40cmdmekxxVzNTblZZQThSQ0V5TmMxVitzWTl1?=
 =?iso-2022-jp?B?MWxuWXJTaFQrNXg1YVdOTEFaSlJKaTVjdE5maE53YVMxL0cwU2NSUncw?=
 =?iso-2022-jp?B?ejZ3VDhmKzd0czdTMFRiQU93cDFxRXhRN01SVFg4ZDhTd2NnZFZmaFE2?=
 =?iso-2022-jp?B?ZG9KRTloZGZ4K1pyNElnU2IrSFVkdXpYaW5aRy8zSHlpeXBXYXRjNmtT?=
 =?iso-2022-jp?B?VnV1WG9xb0lObUlSSGYySU1nc3lzbjFmYkZRMThnZk1KaDFNNE4yeXE0?=
 =?iso-2022-jp?B?d0JNV09maFNoc3dKTDUzOStOeUNlQU8wS3R5MkpnVzFGV3pJWDdOU1Va?=
 =?iso-2022-jp?B?ZFZFQWQvOXM5YjJDc2doS0RXNFRmdkdydDQ5c0JybFJsM0t0elB1ZXh2?=
 =?iso-2022-jp?B?ZFE3V0doMkpYWXo2NStPNTU4WlowZThHWStVbUlCSGM5TGNlTEZ5aDVy?=
 =?iso-2022-jp?B?bjhyYTVVU0krYk1obzlmN0xacTJEK3pNem5XTXY3Q1RjWDBsMTBxT0Rk?=
 =?iso-2022-jp?B?RFFkZzkyK2EzQjB2Zk9FdVI3Ny92UWNVMDRmTXFwc0JFaU40UUh1OHZX?=
 =?iso-2022-jp?B?Q2dScHZtdUI4QVdIOWRHRWM4Y1pIeFAwU2VZZjVRS25rZHBXWUtwOUh6?=
 =?iso-2022-jp?B?MHhlYisvU0QvUU9hK2RxdlR3elEyR040TDd4bGlFeGtaTWxjdkdUeUlv?=
 =?iso-2022-jp?B?TGp3aElvU2NkS0hBNGVsLzkzMU1KR3JpWnNrY1J6N1BHZEJTckpGcXBQ?=
 =?iso-2022-jp?B?cXh3NEhrd1VSNEhSNitxNXYzVDBmUVowT3ZpVUZ1S1loRzZLd09ISCtB?=
 =?iso-2022-jp?B?d1UzeHFaYmxJOGJGRDVTTmFMM0dEZGZYcWVudGg3OE5NcGNKWEd6RlR3?=
 =?iso-2022-jp?B?MklHZlRHVGdTY1B1Z2xnNDU3eG5wUlNaMVE9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYAPR01MB6201.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 90ed0f6b-9488-4212-51d5-08dab5780e06
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Oct 2022 04:27:26.1876
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JnfWscJOlF4eUp1tyPRvNk/G9b3TdvwbtHIdtsHonVf6yCondHKWeMSf40HFCVht2cLLA4vafrgPctwzyg2OUZyv7/nr6l4QwTmfNC5xSgM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB5992
X-OriginatorOrg: toshiba.co.jp
MSSCP.TransferMailToMossAgent: 103
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
I'm porting a V4L2 capture driver from 4.19.y to 5.10.y [1].
When I test the ported driver, I sometimes find a corruption on a captured image.
Because the corruption is exactly aligned with cacheline, I started investigation from map/unmap of DMA-BUF.

The capture driver uses DMA-BUF for videobuf2.
The capture hardware does not have HW-mantained cache coherency with CPU, that is, explicit map/unmap is essential on QBUF/DQBUF.
After some hours of struggle, I found a patch removing cache synchronizations on QBUF/DQBUF.

https://patchwork.kernel.org/project/linux-media/patch/20190124095156.21898-1-paul.kocialkowski@bootlin.com/

When I removed this patch from my 5.10.y working-tree, the driver yielded images without any defects.

***************
Sorry for a mention to a patch released 4 years ago.
The patch removes map/unmap on QBUF/DQBUF to improve the performance of V4L2 decoder device, by reusing previously decoded frames.
However, there seems no cares nor compensations for modifying lifecycle of DMA-BUF, especially on video capture devices.

Would you tell me some idea on this patch:
* Do well-implemented capture drivers work well even if this patch is applied?
* How should a video capture driver call V4L2/videobuf2 APIs, especially when the hardware does not support cache coherency?

***************
[1] FYI: the capture driver is not on mainline yet; the candidate is,
https://lore.kernel.org/all/20220810132822.32534-1-yuji2.ishikawa@toshiba.co.jp/

***************
Sorry for sending the same email message again. I wrongly posted previous one with HTML format.

Regards,
              Yuji Ishikawa

