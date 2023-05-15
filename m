Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 003AC70366F
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 19:10:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243648AbjEORKM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 13:10:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243662AbjEORJ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 13:09:26 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8F40AD0E
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 10:07:56 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-64384274895so9247126b3a.2
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 10:07:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684170476; x=1686762476;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=2nHtEWxnGpGcZQSGGCC9iqpPMY8cRtXXTyviVXLj7sE=;
        b=RfNBq7TDdB2IKmzexzeaLngBcSjUiBcZ76IWWMJjgqNJUzMd+r6cCkMiwv37HGifZ1
         oUgOU3QJmdlwWc4gCYiUibfRVz/LIKi2erGbGCg0J9x/Am6T/uxzV4hNQJAb9I2pLr4n
         x7ERVV7Mwoedg3fxwt/WADMRh/cJMOIRIIWa8P0cFY0z4bVpqPONf2iazLAAUT/pNaO8
         W3cLW8JQPhNRlKzm9JdZlHXzKVG9zlEcuxgS53YlvVkLs3VzTn3CfqPHe0w09VBrRUTx
         cLr++MTEfSCczuMcgvsvTdPa/Pg/vkKTaXFguNsYbaDZ24W+jjA2W37GpSo6TSjXptd+
         VKmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684170476; x=1686762476;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2nHtEWxnGpGcZQSGGCC9iqpPMY8cRtXXTyviVXLj7sE=;
        b=DXGyvtua0nAIQdXIo48RIFJyUZ+C0nv1L4GxZq/Aqp4IgL/c62VEcLsi0f9VTO/Vwq
         +B7ouSBqZJ6tRNyokgWnglaO9HaZxEkoAVKARpQ3kd9PcCzB226wVzfjtDel5T8FSpYZ
         rU7nSkqdYA2UabKeZ5xkzLLufVDQyXZShq4ML1VzmTcR+u8FveYGLI8ga/m6FCQit1BH
         w3jAe3Jc24QhFu+uKHNGuY0EZxaxA4qiUwN9JStn61NG2cFUwsMTrBULF1OqEQiLdhnz
         i84km+fYHyG8Ga9V7bBNUeEp9bev0Zs1H0PAwjdgi8rWIqqNJUqYMUe1m8AXji1KcMLx
         R3eg==
X-Gm-Message-State: AC+VfDxsiZVHXH5yaZDiUl5Du/yR+ulEk2Il0GLXqYpUX8Sjv981iOtD
        qqzD/hFVpa2mRYRaGYfiyN9se+kRZ1RxcmMgJVQ=
X-Google-Smtp-Source: ACHHUZ52HZolmtjdAn8T2k4UpZ3HNolbARPshrUQ24xkpbnjgc72ibaTbyTOGYAaZX0FatvS+jMmVg==
X-Received: by 2002:a05:6a20:12d0:b0:102:f744:a708 with SMTP id v16-20020a056a2012d000b00102f744a708mr24322492pzg.35.1684170475724;
        Mon, 15 May 2023 10:07:55 -0700 (PDT)
Received: from p14s ([2604:3d09:148c:c800:d401:af78:6aa0:cf61])
        by smtp.gmail.com with ESMTPSA id h5-20020a62b405000000b0063f33e216dasm12365831pfn.96.2023.05.15.10.07.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 May 2023 10:07:55 -0700 (PDT)
Date:   Mon, 15 May 2023 11:07:52 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     TingHan Shen =?utf-8?B?KOayiOW7t+e/sCk=?= 
        <TingHan.Shen@mediatek.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "linux-remoteproc@vger.kernel.org" <linux-remoteproc@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "andersson@kernel.org" <andersson@kernel.org>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>
Subject: Re: [PATCH v11 06/11] remoteproc: mediatek: Probe multi-core SCP
Message-ID: <ZGJm6JaSZ5vm9oYT@p14s>
References: <20230510063749.5127-1-tinghan.shen@mediatek.com>
 <20230510063749.5127-7-tinghan.shen@mediatek.com>
 <ZF59xilzufy69RZh@p14s>
 <968894ff6a9ed9cfb71cd28eb3552047e4d298a6.camel@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <968894ff6a9ed9cfb71cd28eb3552047e4d298a6.camel@mediatek.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 15, 2023 at 12:31:04PM +0000, TingHan Shen (沈廷翰) wrote:
> Hi Mathieu,
> 
> On Fri, 2023-05-12 at 11:56 -0600, Mathieu Poirier wrote:
> > External email : Please do not click links or open attachments until you have verified the sender or the content.
> > 
> > 
> > On Wed, May 10, 2023 at 02:37:44PM +0800, Tinghan Shen wrote:
> > > The difference of single-core SCP and multi-core SCP device tree is
> > > the presence of child device nodes described SCP cores. The SCP
> > > driver populates the platform device and checks the child nodes
> > > to identify whether it's a single-core SCP or a multi-core SCP.
> > > 
> > > Add the remoteproc instances of multi-core SCP to the SCP cluster list.
> > > When the SCP driver is removed, it cleanup resources by walking
> > > through the cluster list.
> > > 
> > > Signed-off-by: Tinghan Shen <tinghan.shen@mediatek.com>
> > > ---
> > >  drivers/remoteproc/mtk_scp.c | 135 ++++++++++++++++++++++++++++++-----
> > >  1 file changed, 117 insertions(+), 18 deletions(-)
> > > 
> > > diff --git a/drivers/remoteproc/mtk_scp.c b/drivers/remoteproc/mtk_scp.c
> > > index ff73c6dd9637..87215a0e145e 100644
> > > --- a/drivers/remoteproc/mtk_scp.c
> > > +++ b/drivers/remoteproc/mtk_scp.c
> > > @@ -864,7 +864,8 @@ static void scp_remove_rpmsg_subdev(struct mtk_scp *scp)
> > >  }
> > > 
> > >  static struct mtk_scp *scp_rproc_init(struct platform_device *pdev,
> > > -                                   struct mtk_scp_of_cluster *scp_cluster)
> > > +                                   struct mtk_scp_of_cluster *scp_cluster,
> > > +                                   const struct mtk_scp_of_data *of_data)
> > >  {
> > >       struct device *dev = &pdev->dev;
> > >       struct device_node *np = dev->of_node;
> > > @@ -887,7 +888,7 @@ static struct mtk_scp *scp_rproc_init(struct platform_device *pdev,
> > >       scp = rproc->priv;
> > >       scp->rproc = rproc;
> > >       scp->dev = dev;
> > > -     scp->data = of_device_get_match_data(dev);
> > > +     scp->data = of_data;
> > >       platform_device_add_data(pdev, &scp, sizeof(scp));
> > > 
> > >       scp->reg_base = scp_cluster->reg_base;
> > > @@ -938,10 +939,6 @@ static struct mtk_scp *scp_rproc_init(struct platform_device *pdev,
> > >               goto remove_subdev;
> > >       }
> > > 
> > > -     ret = rproc_add(rproc);
> > > -     if (ret)
> > > -             goto remove_subdev;
> > > -
> > 
> > This should have been done in the previous patch.
> 
> Ok.
> 
> > 
> > >       return scp;
> > > 
> > >  remove_subdev:
> > > @@ -956,19 +953,116 @@ static struct mtk_scp *scp_rproc_init(struct platform_device *pdev,
> > >       return ERR_PTR(ret);
> > >  }
> > > 
> > > +static void scp_rproc_free(struct mtk_scp *scp)
> > > +{
> > > +     int i;
> > > +
> > > +     scp_remove_rpmsg_subdev(scp);
> > > +     scp_ipi_unregister(scp, SCP_IPI_INIT);
> > > +     scp_unmap_memory_region(scp);
> > > +     for (i = 0; i < SCP_IPI_MAX; i++)
> > > +             mutex_destroy(&scp->ipi_desc[i].lock);
> > > +     mutex_destroy(&scp->send_lock);
> > > +}
> > > +
> > > +static int scp_is_single_core(struct platform_device *pdev)
> > > +{
> > > +     struct device *dev = &pdev->dev;
> > > +     struct device_node *np = dev_of_node(dev);
> > > +     struct device_node *child;
> > > +
> > > +     child = of_get_next_available_child(np, NULL);
> > > +     if (!child)
> > > +             return dev_err_probe(dev, -ENODEV, "No child node\n");
> > > +
> > > +     of_node_put(child);
> > > +     return of_node_name_eq(child, "cros-ec-rpmsg");
> > > +}
> > > +
> > >  static int scp_cluster_init(struct platform_device *pdev)
> > >  {
> > > -     struct mtk_scp *scp;
> > > +     struct mtk_scp *scp, *temp;
> > >       struct mtk_scp_of_cluster *scp_cluster = platform_get_drvdata(pdev);
> > >       struct list_head *cluster = &scp_cluster->mtk_scp_cluster;
> > > 
> > > -     scp = scp_rproc_init(pdev, scp_cluster);
> > > -     if (IS_ERR(scp))
> > > -             return PTR_ERR(scp);
> > > +     struct device *dev = &pdev->dev;
> > > +     struct device_node *np = dev_of_node(dev);
> > > +     struct platform_device *cpdev;
> > > +     struct device_node *child;
> > > +     const struct mtk_scp_of_data **cluster_of_data;
> > > +     int core_id = 0;
> > > +     int ret;
> > > +
> > > +     ret = scp_is_single_core(pdev);
> > > +     if (ret < 0)
> > > +             return ret;
> > > +
> > > +     if (ret) {
> > > +             dev_dbg(dev, "single-core scp\n");
> > > +
> > > +             /* When using the SCP node phandle on exported SCP APIs, the drvdata
> > > +              * is expected to be the mtk_scp object, and as a result, it is intended
> > > +              * to be overwritten for single-core SCP usage.
> > > +              */
> > 
> > Is this comment still relevant?
> 
> No, I'll remove it. 
> 
> > 
> > > +             scp = scp_rproc_init(pdev, scp_cluster, of_device_get_match_data(dev));
> > > +             if (IS_ERR(scp))
> > > +                     return PTR_ERR(scp);
> > > +
> > > +             list_add_tail(&scp->elem, cluster);
> > 
> > This is getting messy.  Please add two new functions, i.e scp_add_single_core()
> > and scp_add_multi_core().
> 
> Ok.
> 
> > 
> > > +     } else {
> > > +             dev_dbg(dev, "multi-core scp\n");
> > > +
> > > +             cluster_of_data = (const struct mtk_scp_of_data **)of_device_get_match_data(dev);
> > > +
> > > +             for_each_available_child_of_node(np, child) {
> > > +                     if (!cluster_of_data[core_id]) {
> > > +                             ret = -EINVAL;
> > > +                             dev_err(dev, "Not support core %d\n", core_id);
> > > +                             of_node_put(child);
> > > +                             goto init_fail;
> > > +                     }
> > > +
> > > +                     cpdev = of_find_device_by_node(child);
> > > +                     if (!cpdev) {
> > > +                             ret = -ENODEV;
> > > +                             dev_err(dev, "Not found platform device for core %d\n", core_id);
> > > +                             of_node_put(child);
> > > +                             goto init_fail;
> > > +                     }
> > > +
> > > +                     scp = scp_rproc_init(cpdev, scp_cluster, cluster_of_data[core_id]);
> > > +                     if (IS_ERR(scp)) {
> > > +                             dev_err(dev, "Failed to initialize core %d rproc\n", core_id);
> > > +                             put_device(&cpdev->dev);
> > > +                             of_node_put(child);
> > > +                             goto init_fail;
> > > +                     }
> > > +                     list_add_tail(&scp->elem, cluster);
> > > +                     put_device(&cpdev->dev);
> > > +
> > > +                     core_id++;
> > > +             }
> > > +     }
> > > 
> > > -     list_add_tail(&scp->elem, cluster);
> > > +     list_for_each_entry_safe_reverse(scp, temp, cluster, elem) {
> > > +             ret = rproc_add(scp->rproc);
> > 
> > Call rproc_add() in the for_each_available_child_of_node() loop above.  That way
> > it if fails you can call scp_rproc_free() right away and jump to init_fail to
> > deal with the other cores on the list.
> 
> Ok, I'll update it in next version.
> 
> > 
> > > +             if (ret)
> > > +                     goto add_fail;
> > > +     }
> > > 
> > >       return 0;
> > > +
> > > +add_fail:
> > > +     list_for_each_entry_continue(scp, cluster, elem) {
> > > +             rproc_del(scp->rproc);
> > > +     }
> > > +init_fail:
> > > +     list_for_each_entry_safe_reverse(scp, temp, cluster, elem) {
> > > +             list_del(&scp->elem);
> > > +             scp_rproc_free(scp);
> > > +     }
> > > +
> > 
> > There are a serious problems with the code in both labels above.  I will let you
> > think about that and I will stop here for this revision.
> > 
> > Mathieu
> 
> May be the problem is the possible null access of *scp?
> Or, the resources bound with cpdev should be released at here?

The first problem is related to list processing.  Function
list_for_each_entry_safe_reverse() starts at the end of the list and stops if an
error is encountered.  From there we go back the other way with
list_for_each_entry_continue() and then reverse again for
list_for_each_entry_safe_reverse().  This back and forth is error prone and very
hard to maintain.  

The second problem is with rproc_del()... Does it need to be there?

> 
> 
> > 
> > > +     return ret;
> > >  }
> > > 
> > >  static int scp_probe(struct platform_device *pdev)
> > > @@ -1005,6 +1099,10 @@ static int scp_probe(struct platform_device *pdev)
> > >       INIT_LIST_HEAD(&scp_cluster->mtk_scp_cluster);
> > >       platform_set_drvdata(pdev, scp_cluster);
> > > 
> > > +     ret = devm_of_platform_populate(dev);
> > > +     if (ret)
> > > +             return dev_err_probe(dev, ret, "Failed to populate platform devices\n");
> > > +
> > >       ret = scp_cluster_init(pdev);
> > >       if (ret)
> > >               return ret;
> > > @@ -1016,17 +1114,11 @@ static int scp_remove(struct platform_device *pdev)
> > >  {
> > >       struct mtk_scp_of_cluster *scp_cluster = platform_get_drvdata(pdev);
> > >       struct mtk_scp *scp, *temp;
> > > -     int i;
> > > 
> > >       list_for_each_entry_safe_reverse(scp, temp, &scp_cluster->mtk_scp_cluster, elem) {
> > >               list_del(&scp->elem);
> > >               rproc_del(scp->rproc);
> > > -             scp_remove_rpmsg_subdev(scp);
> > > -             scp_ipi_unregister(scp, SCP_IPI_INIT);
> > > -             scp_unmap_memory_region(scp);
> > > -             for (i = 0; i < SCP_IPI_MAX; i++)
> > > -                     mutex_destroy(&scp->ipi_desc[i].lock);
> > > -             mutex_destroy(&scp->send_lock);
> > > +             scp_rproc_free(scp);
> > >       }
> > > 
> > >       return 0;
> > > @@ -1106,12 +1198,19 @@ static const struct mtk_scp_of_data mt8195_of_data_c1 = {
> > >       .host_to_scp_int_bit = MT8195_CORE1_HOST_IPC_INT_BIT,
> > >  };
> > > 
> > > +static const struct mtk_scp_of_data *mt8195_of_data_cores[] = {
> > > +     &mt8195_of_data,
> > > +     &mt8195_of_data_c1,
> > > +     NULL
> > > +};
> > > +
> > >  static const struct of_device_id mtk_scp_of_match[] = {
> > >       { .compatible = "mediatek,mt8183-scp", .data = &mt8183_of_data },
> > >       { .compatible = "mediatek,mt8186-scp", .data = &mt8186_of_data },
> > >       { .compatible = "mediatek,mt8188-scp", .data = &mt8188_of_data },
> > >       { .compatible = "mediatek,mt8192-scp", .data = &mt8192_of_data },
> > >       { .compatible = "mediatek,mt8195-scp", .data = &mt8195_of_data },
> > > +     { .compatible = "mediatek,mt8195-scp-dual", .data = &mt8195_of_data_cores },
> > >       {},
> > >  };
> > >  MODULE_DEVICE_TABLE(of, mtk_scp_of_match);
> > > --
> > > 2.18.0
> > > 
> 
> -- 
> Best regards,
> TingHan
