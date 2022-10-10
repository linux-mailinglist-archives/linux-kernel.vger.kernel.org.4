Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B638E5FA0CA
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 16:58:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229967AbiJJO64 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 10:58:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229658AbiJJO6h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 10:58:37 -0400
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD2161EC58
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 07:58:36 -0700 (PDT)
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29ABfpOe008858;
        Mon, 10 Oct 2022 09:57:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=PODMain02222019;
 bh=3cuiG9m6vIhjwqp/IWKVUxSa8Ym/VaVsO8Icgx0or3w=;
 b=PhEkOhV1EFCAlSWBlcFbVi8iXloP49/wnrlRN4680dp+XnnqH150J260Z+p4xlcunlrL
 I9fEvT+uNXes6at0cnhM5ekMptUU7zzfQzYeAeruxvMQy1y1ybPKcyMUzxH/3IFn4Avc
 Z+ZlJ5YsX0/cZHlPgmxkvaOQRJ5XlC6iBDDbpAElNyciU8S7LFOj4NEameb4ecZ4ujIW
 zSehU8XfcP1mHj5q588B+VWlALaSKLne7PX6NNhuKRgMeV034o6Se2ORnd/0heKvtdG2
 PmGSVKLFl4QVFYb5L+N/Hp+GgJE/7KO/uHNWS+8gf7Y5cJfqd6vP77gYmahUOrRgPFHd hg== 
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
        by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3k36m1t472-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 10 Oct 2022 09:57:28 -0500
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.12; Mon, 10 Oct
 2022 09:57:26 -0500
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.2.1118.12 via Frontend
 Transport; Mon, 10 Oct 2022 09:57:26 -0500
Received: from ediswmail.ad.cirrus.com (ediswmail.ad.cirrus.com [198.61.86.93])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id C2AA1468;
        Mon, 10 Oct 2022 14:57:26 +0000 (UTC)
Date:   Mon, 10 Oct 2022 14:57:26 +0000
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     Xiaolei Wang <xiaolei.wang@windriver.com>
CC:     <lgirdwood@gmail.com>, <broonie@kernel.org>, <perex@perex.cz>,
        <tiwai@suse.com>, <steve@sk2.org>, <geert+renesas@glider.be>,
        <chi.minghao@zte.com.cn>, <aford173@gmail.com>,
        <patches@opensource.cirrus.com>, <alsa-devel@alsa-project.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ASoC: wm8962: Add an event handler for TEMP_HP and
 TEMP_SPK
Message-ID: <20221010145726.GD92394@ediswmail.ad.cirrus.com>
References: <20221010092014.2229246-1-xiaolei.wang@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20221010092014.2229246-1-xiaolei.wang@windriver.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Proofpoint-GUID: hsjsF0xQgJbGqZcG_8mLtdHL5xkhVTFg
X-Proofpoint-ORIG-GUID: hsjsF0xQgJbGqZcG_8mLtdHL5xkhVTFg
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 10, 2022 at 05:20:14PM +0800, Xiaolei Wang wrote:
> In wm8962 driver, the WM8962_ADDITIONAL_CONTROL_4 is used as a volatile
> register, but this register mixes a bunch of volatile status bits and a
> bunch of non-volatile control bits. The dapm widgets TEMP_HP and
> TEMP_SPK leverages the control bits in this register. After the wm8962
> probe, the regmap will bet set to cache only mode, then a read error
> like below would be triggered when trying to read the initial power
> state of the dapm widgets TEMP_HP and TEMP_SPK.
>   wm8962 0-001a: ASoC: error at soc_component_read_no_lock
>   on wm8962.0-001a: -16
> 
> In order to fix this issue, we add event handler to actually power
> up/down these widgets. With this change, we also need to explicitly
> power off these widgets in the wm8962 probe since they are enabled
> by default.
> 
> Signed-off-by: Xiaolei Wang <xiaolei.wang@windriver.com>
> ---

Acked-by: Charles Keepax <ckeepax@opensource.cirrus.com>

Thanks,
Charles
