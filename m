Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EE2A7256B1
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 10:01:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238393AbjFGIBu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 04:01:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233416AbjFGIBr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 04:01:47 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8EF7E79;
        Wed,  7 Jun 2023 01:01:45 -0700 (PDT)
Received: from [IPV6:2001:b07:2ed:14ed:a962:cd4d:a84:1eab] (unknown [IPv6:2001:b07:2ed:14ed:a962:cd4d:a84:1eab])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 85BE46606EE7;
        Wed,  7 Jun 2023 09:01:43 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1686124904;
        bh=7/zTInyb0fTEFIGhobmXUcrdn5DzghzCHPw6C0UuWec=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=YjIVS2xVlYnQjrQAiuIY81ZtB6q7gAfyWuV4UcbWh30M0SgFiQqHhftI5121ESmQ4
         B/gdRqAV0swiR9QCHPVcu7d84tLdMLid+Idhq5+eqWLpcAPnusbi46f3G+WXif5zGL
         odSAkMB0HvUsHSX6beyNhNtpkLMrm3UWk2hTnbn4yLIX28dTXDrWKjl+WcrQjfF9up
         E2vIVZOD6HDL0tkVHCtWkyad7EWTS2jpGi8pxK4+H7e0K/z+anHlZfGT1mw6izbHj2
         BYrCHNIDrsp64uTw14xn6sLp/YHhrq8SYGRijOFJJm2h0W2UowfLIp4Zf5iQE+tAPI
         6uHi4XXLTIYzQ==
Message-ID: <60809262-26ca-50f1-9ee4-705d46723517@collabora.com>
Date:   Wed, 7 Jun 2023 10:01:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH v13 05/11] remoteproc: mediatek: Introduce cluster on
 single-core SCP
Content-Language: en-US
To:     =?UTF-8?B?VGluZ0hhbiBTaGVuICjmsojlu7fnv7Ap?= 
        <TingHan.Shen@mediatek.com>,
        "mathieu.poirier@linaro.org" <mathieu.poirier@linaro.org>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "andersson@kernel.org" <andersson@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>
Cc:     "linux-remoteproc@vger.kernel.org" <linux-remoteproc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>
References: <20230607072222.8628-1-tinghan.shen@mediatek.com>
 <20230607072222.8628-6-tinghan.shen@mediatek.com>
 <d8053fc1-cace-b14b-57c6-387c0d664837@collabora.com>
 <9c710fca38ba53da3ba1aaf32a2221676eb584be.camel@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <9c710fca38ba53da3ba1aaf32a2221676eb584be.camel@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 07/06/23 10:00, TingHan Shen (沈廷翰) ha scritto:
> Hi Angelo,
> 
> On Wed, 2023-06-07 at 09:43 +0200, AngeloGioacchino Del Regno wrote:
>> Il 07/06/23 09:22, Tinghan Shen ha scritto:
>>> This is the preliminary step for probing multi-core SCP.
>>> The initialization procedure for remoteproc is similar for both
>>> single-core and multi-core architectures and is reusing to avoid
>>> redundant code.
>>>
>>> Rewrite the probing flow of single-core SCP to adapt with the 'cluster'
>>> concept needed by probing the multi-core SCP. The main differences
>>> are,
>>> - the SCP core object(s) is maintained at the cluster list instead of at
>>>     the platofmr device driver data property.
>>
>> s/platofmr/platform/g
>>
>>> - save the cluster information at the platofmr device driver data property.
>>> - In order to keep the compatibility of exported SCP APIs which getting
>>>     the SCP core object by SCP node phandle, move the SCP core object
>>>     pointers to the platform device platform data property.
>>>
>>> The registers of config and l1tcm are shared for multi-core
>>> SCP. Reuse the mapped addresses for all cores.
>>>
>>> Signed-off-by: Tinghan Shen <tinghan.shen@mediatek.com>
>>> ---
>>>    drivers/remoteproc/mtk_common.h |   2 +
>>>    drivers/remoteproc/mtk_scp.c    | 151 +++++++++++++++++++++++---------
>>>    2 files changed, 112 insertions(+), 41 deletions(-)
>>>
>>> diff --git a/drivers/remoteproc/mtk_common.h b/drivers/remoteproc/mtk_common.h
>>> index c0905aec3b4b..56395e8664cb 100644
>>> --- a/drivers/remoteproc/mtk_common.h
>>> +++ b/drivers/remoteproc/mtk_common.h
>>> @@ -128,6 +128,8 @@ struct mtk_scp {
>>>    	size_t dram_size;
>>>    
>>>    	struct rproc_subdev *rpmsg_subdev;
>>> +
>>> +	struct list_head elem;
>>>    };
>>>    
>>>    /**
>>> diff --git a/drivers/remoteproc/mtk_scp.c b/drivers/remoteproc/mtk_scp.c
>>> index d66822dad943..c8fc6b46f82b 100644
>>> --- a/drivers/remoteproc/mtk_scp.c
>>> +++ b/drivers/remoteproc/mtk_scp.c
>>> @@ -23,6 +23,14 @@
>>>    #define MAX_CODE_SIZE 0x500000
>>>    #define SECTION_NAME_IPI_BUFFER ".ipi_buffer"
>>>    
>>> +struct mtk_scp_of_cluster {
>>> +	void __iomem *reg_base;
>>> +	void __iomem *l1tcm_base;
>>> +	size_t l1tcm_size;
>>> +	phys_addr_t l1tcm_phys;
>>> +	struct list_head mtk_scp_list;
>>> +};
>>> +
>>>    /**
>>>     * scp_get() - get a reference to SCP.
>>>     *
>>> @@ -51,7 +59,7 @@ struct mtk_scp *scp_get(struct platform_device *pdev)
>>>    		return NULL;
>>>    	}
>>>    
>>> -	return platform_get_drvdata(scp_pdev);
>>> +	return *(struct mtk_scp **)dev_get_platdata(&scp_pdev->dev);
>>>    }
>>>    EXPORT_SYMBOL_GPL(scp_get);
>>>    
>>> @@ -810,14 +818,14 @@ static void scp_unmap_memory_region(struct mtk_scp *scp)
>>>    static int scp_register_ipi(struct platform_device *pdev, u32 id,
>>>    			    ipi_handler_t handler, void *priv)
>>>    {
>>> -	struct mtk_scp *scp = platform_get_drvdata(pdev);
>>> +	struct mtk_scp *scp = *(struct mtk_scp **)dev_get_platdata(&pdev->dev);
>>>    
>>>    	return scp_ipi_register(scp, id, handler, priv);
>>>    }
>>>    
>>>    static void scp_unregister_ipi(struct platform_device *pdev, u32 id)
>>>    {
>>> -	struct mtk_scp *scp = platform_get_drvdata(pdev);
>>> +	struct mtk_scp *scp = *(struct mtk_scp **)dev_get_platdata(&pdev->dev);
>>>    
>>>    	scp_ipi_unregister(scp, id);
>>>    }
>>> @@ -825,7 +833,7 @@ static void scp_unregister_ipi(struct platform_device *pdev, u32 id)
>>>    static int scp_send_ipi(struct platform_device *pdev, u32 id, void *buf,
>>>    			unsigned int len, unsigned int wait)
>>>    {
>>> -	struct mtk_scp *scp = platform_get_drvdata(pdev);
>>> +	struct mtk_scp *scp = *(struct mtk_scp **)dev_get_platdata(&pdev->dev);
>>>    
>>>    	return scp_ipi_send(scp, id, buf, len, wait);
>>>    }
>>> @@ -855,7 +863,8 @@ static void scp_remove_rpmsg_subdev(struct mtk_scp *scp)
>>>    	}
>>>    }
>>>    
>>> -static int scp_probe(struct platform_device *pdev)
>>> +static struct mtk_scp *scp_rproc_init(struct platform_device *pdev,
>>> +				      struct mtk_scp_of_cluster *scp_cluster)
>>>    {
>>>    	struct device *dev = &pdev->dev;
>>>    	struct device_node *np = dev->of_node;
>>> @@ -867,52 +876,42 @@ static int scp_probe(struct platform_device *pdev)
>>>    
>>>    	ret = rproc_of_parse_firmware(dev, 0, &fw_name);
>>>    	if (ret < 0 && ret != -EINVAL)
>>> -		return ret;
>>> +		return ERR_PTR(ret);
>>>    
>>>    	rproc = devm_rproc_alloc(dev, np->name, &scp_ops, fw_name, sizeof(*scp));
>>> -	if (!rproc)
>>> -		return dev_err_probe(dev, -ENOMEM, "unable to allocate remoteproc\n");
>>> +	if (!rproc) {
>>> +		dev_err(dev, "unable to allocate remoteproc\n");
>>> +		return ERR_PTR(-ENOMEM);
>>
>> Why are you converting those dev_err_probe to dev_err->return?!
>>
>> Regards,
>> Angelo
> 
> It's because the return type of this function changed from "int" to "struct mtk_scp *".
> Maybe I should change them to "ERR_PTR(dev_err_probe(...))" ?
> 

Oh, sorry - you're right. No, it's fine as you did it.

Cheers

