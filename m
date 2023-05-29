Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8E6371441A
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 08:17:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229961AbjE2GRl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 02:17:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229682AbjE2GRh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 02:17:37 -0400
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43D2DDF
        for <linux-kernel@vger.kernel.org>; Sun, 28 May 2023 23:17:13 -0700 (PDT)
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20230529061647epoutp04caea00a517fd42909e6e6fef8bbdf187~jiLeh_6L42201622016epoutp04M
        for <linux-kernel@vger.kernel.org>; Mon, 29 May 2023 06:16:47 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20230529061647epoutp04caea00a517fd42909e6e6fef8bbdf187~jiLeh_6L42201622016epoutp04M
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1685341007;
        bh=m9xm23Wp2kQOMHbgCRHdO14RiDhZu+JxzizlMdAOtQ8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=IxEN0twxctauISsm+AhWBfCy29Ay6tPARNcM3Q+RGdirvyVLcSa8HJS8I5s/LAH4/
         XxAFtLcVySQMx0GVPZIwM3tMZtlW71nlZft4u88e+0DDmK1FSwVL4kEcOjy+hlFTfJ
         nBF0UM6gcC4zNaCnJuq6zWwW9FL9Dx5gCf0ea7Pg=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTP id
        20230529061647epcas5p16d9da11f78a3f5f932f1e614131b214b~jiLeDlbsC1342113421epcas5p1j;
        Mon, 29 May 2023 06:16:47 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.38.182]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4QV4zw24pmz4x9Q0; Mon, 29 May
        2023 06:16:44 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
        epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
        1B.08.16380.B4344746; Mon, 29 May 2023 15:16:43 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
        20230529061643epcas5p47e20ec98a9eb8325bbe7e553af5776ea~jiLaCvpr73133831338epcas5p4b;
        Mon, 29 May 2023 06:16:43 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20230529061643epsmtrp2da734ed323dc32503efaff9613c9aeda~jiLaCBjsh1312013120epsmtrp2V;
        Mon, 29 May 2023 06:16:43 +0000 (GMT)
X-AuditID: b6c32a4b-7dffd70000013ffc-55-6474434b1cf2
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        FD.EA.27706.A4344746; Mon, 29 May 2023 15:16:42 +0900 (KST)
Received: from green245 (unknown [107.99.41.245]) by epsmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20230529061639epsmtip2c2be8ccb0cc7d6d062e6a4d4c5752158~jiLXItMeV0600706007epsmtip2a;
        Mon, 29 May 2023 06:16:39 +0000 (GMT)
Date:   Mon, 29 May 2023 11:43:28 +0530
From:   Kanchan Joshi <joshi.k@samsung.com>
To:     "min15.li" <min15.li@samsung.com>
Cc:     kbusch@kernel.org, axboe@kernel.dk, hch@lst.de, sagi@grimberg.me,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] nvme: fix miss command type check
Message-ID: <20230529061328.GA11198@green245>
MIME-Version: 1.0
In-Reply-To: <20230526170656.55303-1-min15.li@samsung.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprOJsWRmVeSWpSXmKPExsWy7bCmuq63c0mKwarp/Bar7/azWaxcfZTJ
        YtKha4wWl3fNYbOYv+wpu8XyVR1MFutev2dxYPc4f28ji8fls6Uem1Z1snlsXlLvsftmA5tH
        35ZVjB6fN8kFsEdl22SkJqakFimk5iXnp2TmpdsqeQfHO8ebmhkY6hpaWpgrKeQl5qbaKrn4
        BOi6ZeYAnaOkUJaYUwoUCkgsLlbSt7Mpyi8tSVXIyC8usVVKLUjJKTAp0CtOzC0uzUvXy0st
        sTI0MDAyBSpMyM5Y/fwfe8FU9ore1k6mBsbZbF2MnBwSAiYSP7+1sYDYQgK7GSUWNgZ2MXIB
        2Z8YJZbvO8UM4XwDcmbtZ4HpuPP1ABtEYi+jxM2+y0wQzjNGiV29R8CqWARUJVpPPwdKcHCw
        CWhKXJhcChIWAQrvvX2MHaSeWaCFUeLlhH/MIAlhAUuJ5ps7WEFsXgFdiRtzZzND2IISJ2c+
        AZvJKWAlsWHeZHYQW1RAWeLAtuNgiyUEOjkkZlw6ygpxnotE7/f17BC2sMSr41ugbCmJz+/2
        Qj2dLHFp5jkmCLtE4vGeg1C2vUTrqX6wxcwCGRKnHkyEsvkken8/AXtGQoBXoqNNCKJcUeLe
        pKdQa8UlHs5YAmV7SOyasYAVEii9jBJHp19jncAoNwvJP7OQrICwrSQ6PzSxzgJawSwgLbH8
        HweEqSmxfpf+AkbWVYySqQXFuempxaYFxnmp5fBITs7P3cQITqFa3jsYHz34oHeIkYmD8RCj
        BAezkgivbWJxihBvSmJlVWpRfnxRaU5q8SFGU2D8TGSWEk3OBybxvJJ4QxNLAxMzMzMTS2Mz
        QyVxXnXbk8lCAumJJanZqakFqUUwfUwcnFINTGq+j7ZbX8l/7MVw2f5L/T1bl3uPWDZHOTYa
        yJnsbdyU+GRP3j9LVfOVm41sZ+yudZZe7Lx8vb6CRelhg1lSlz+9V+GbtVTvY/8FvoknFmdI
        Rz7+ckMpvkZtp4/MxD312nMEc2P101Tv7Uq/ddibO1tuolW3U07+3kUZcSfa+7pvnYtc9JSj
        82Nk1uG9BQ2vQrN4LsrbB55Vjl3KEn4hpExx9SLTRHetWRX7C8J5vc+dmlp8c7uyZ/TlVq+/
        CX3v+idEsu15pK/Ft3htzoW01KLby1e53FJbc7DP8WqiVMjzRo0Wn4lOpfWvZ+nFqt44kTdN
        Uubi36hPL1+kvevxfjDfem3J77gjB+/829QwUYmlOCPRUIu5qDgRAAnUDuYqBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrGLMWRmVeSWpSXmKPExsWy7bCSvK6Xc0mKwf37lhar7/azWaxcfZTJ
        YtKha4wWl3fNYbOYv+wpu8XyVR1MFutev2dxYPc4f28ji8fls6Uem1Z1snlsXlLvsftmA5tH
        35ZVjB6fN8kFsEdx2aSk5mSWpRbp2yVwZTzd+IGl4DhLxaE/3SwNjM+Zuxg5OSQETCTufD3A
        1sXIxSEksJtR4tSeE6wQCXGJ5ms/2CFsYYmV/56zQxQ9YZT4vrGdCSTBIqAq0Xr6OZDNwcEm
        oClxYXIpSFgEKLz39jGwemaBFkaJlxP+gW0TFrCUaL65A2wBr4CuxI25s5khhvYySvxadIMZ
        IiEocXLmExYQm1nATGLe5ofMIAuYBaQllv/jAAlzClhJbJg3Gew4UQFliQPbjjNNYBSchaR7
        FpLuWQjdCxiZVzFKphYU56bnFhsWGOallusVJ+YWl+al6yXn525iBEeFluYOxu2rPugdYmTi
        YDzEKMHBrCTCa5tYnCLEm5JYWZValB9fVJqTWnyIUZqDRUmc90LXyXghgfTEktTs1NSC1CKY
        LBMHp1QDk+nZo0eWep5qmcuee42DL0d7jc5jn81FfTV2TMySTWtCq213bk3dL/6Ki+PTsg0i
        k+wvtL6YFrhe6P+KCacKJIrvyt5yXm47m29W9AvLbNZ1r+qYjMqXugi0L/gUGRW79bBSjOrZ
        R3cn1zvd68rzu8Ud9JRZp/ygwHuP0gamrKarjaEHFZYtP/nwd7hFt1Pn/MtT+c3c757R/CP3
        +4qiotwqRUY3LeFW6SVXFJL96n6sfPl1k+HbrV4Lr0+ZdJ3P2fb2wY8iuY9jhfZbn/g4/bPm
        J7PO1Bkz37VkcduqMnyuqLNbcFt3jYtW39SDt20bXvVYCEvsmvxJf03YAZ+XM3wThTNeaE86
        UekxJah5qhJLcUaioRZzUXEiAGNS9W/5AgAA
X-CMS-MailID: 20230529061643epcas5p47e20ec98a9eb8325bbe7e553af5776ea
X-Msg-Generator: CA
Content-Type: multipart/mixed;
        boundary="----kPHV7voJGfjLavpOfz2TLZSfqzzSedGz1kraSQUx2cheHG0X=_2b02d_"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230526090834epcas5p197a90228102b26759f9b957c50d3bb6b
References: <CGME20230526090834epcas5p197a90228102b26759f9b957c50d3bb6b@epcas5p1.samsung.com>
        <20230526170656.55303-1-min15.li@samsung.com>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

------kPHV7voJGfjLavpOfz2TLZSfqzzSedGz1kraSQUx2cheHG0X=_2b02d_
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Disposition: inline

On Fri, May 26, 2023 at 05:06:56PM +0000, min15.li wrote:
>In the function nvme_passthru_end(),only the value of the command opcode is
>checked, without checking the command type (IO command or Admin command).
>When we send a Dataset Management command (The opcode of the Dataset
>Management command is the same as the Set Feature command),kernel
>thinks it is a set feature command, then sets the controller's keep
> alive interval, and calls nvme_keep_alive_work().
>
>Signed-off-by: min15.li <min15.li@samsung.com>

Reviewed-by: Kanchan Joshi <joshi.k@samsung.com>



------kPHV7voJGfjLavpOfz2TLZSfqzzSedGz1kraSQUx2cheHG0X=_2b02d_
Content-Type: text/plain; charset="utf-8"


------kPHV7voJGfjLavpOfz2TLZSfqzzSedGz1kraSQUx2cheHG0X=_2b02d_--
