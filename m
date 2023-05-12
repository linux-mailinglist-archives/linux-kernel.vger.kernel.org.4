Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9761E700947
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 15:38:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241297AbjELNiM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 09:38:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241281AbjELNiI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 09:38:08 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DED2B13849
        for <linux-kernel@vger.kernel.org>; Fri, 12 May 2023 06:38:06 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-64a9335a8e7so5655935b3a.0
        for <linux-kernel@vger.kernel.org>; Fri, 12 May 2023 06:38:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683898686; x=1686490686;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=XNxZTNO7D9ObZ8vOcMXVGazHEEVb2c+NF1aDFDFH7DM=;
        b=YKPlD/uCoqEk3zob/jbIjUOVuiyBL4crRQbBjz/7JDAHYOVEpFZnmH6rHuxs4jbwoG
         1qtYfpef/TcWtY4pTcsw5jL585W0toJQ3WtYlcEjQ62OeCfdNjeihwa5xBZbqeVSkMuu
         Fgzr2t4VnhHBZzdhHAxZLbpTm+3qtlszLbzJKzo03e11wYkfWLp01Si+5EcHqQV/hml/
         LuGuEEzzxkBXMGUxofWdK/exeWZuVEjvn/3kHdAwcFDO9E4qO6qoDuzR+ebYiUHVWLp0
         yJB3U8GY1GA+CLexyHvS7qFKhlhT+uQhLmUUcx/VESw6bBnqBLdKPQv/Mq3hij6HGOXm
         7RSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683898686; x=1686490686;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XNxZTNO7D9ObZ8vOcMXVGazHEEVb2c+NF1aDFDFH7DM=;
        b=a7aO762JZCKl8Ck+sDZNkMmh4AM+jOhpZwWAQ9cxHFuz/MU4qY3aX3LyPVlpdGJeXn
         eGjbpmZPo74cGjtCqFiaKbgPaei478L4NcitC6GIQwBkrAmJxWO3s6d2+uiXtP6H5lz+
         x8ZFZ+1zYnlKk2yNAB5cGD6rJgjTeH4djWZpCJVJvB2JX4bU916Jqq38pKozfwbdBg/l
         a5lj1jDYm4bhdBJRwtBSUl79WG/rIFOCpbvyzDiy+8Hml49he3HgE/yi5R4vSIm7iSN1
         t6rGKlF2fGXQQ1L6GvKAcXsWnxK+Gj/yfht+WCjXxAlZFae2nIPWwmQDhiWgcI0h4yqU
         F9EQ==
X-Gm-Message-State: AC+VfDxMucowP3OsIdNJOn0qhu4eHpzfm2O/pm3wgI/d7N5vnj/26jPI
        SN46HfUXdgRPU42RzQcCxHZDYQUakYmUlA0Xj2G/Yg==
X-Google-Smtp-Source: ACHHUZ5x5rNNHXImOFnMBQaOPcrvO1ueMVR3kvli10xvSUMTslM0qxwiHUW2eerJJ+LJVDEQ476Yb+lv9+Kc9ELSv78=
X-Received: by 2002:a17:902:ea08:b0:1ad:e2b6:d2a0 with SMTP id
 s8-20020a170902ea0800b001ade2b6d2a0mr2832259plg.11.1683898686185; Fri, 12 May
 2023 06:38:06 -0700 (PDT)
MIME-Version: 1.0
References: <20230512023933.961-1-hejunhao3@huawei.com>
In-Reply-To: <20230512023933.961-1-hejunhao3@huawei.com>
From:   Mike Leach <mike.leach@linaro.org>
Date:   Fri, 12 May 2023 14:37:54 +0100
Message-ID: <CAJ9a7VgX+mf-J6jipQgJY7=F2vJzLhF9XcBxHAV7pCwiqPdbnw@mail.gmail.com>
Subject: Re: [PATCH] coresight: etm4x: fix trctraceid sysfs always invisible
To:     Junhao He <hejunhao3@huawei.com>
Cc:     mathieu.poirier@linaro.org, suzuki.poulose@arm.com,
        leo.yan@linaro.org, jonathan.cameron@huawei.com,
        coresight@lists.linaro.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
        linuxarm@huawei.com, yangyicong@huawei.com, shenyang39@huawei.com,
        prime.zeng@hisilicon.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

Thanks for spotting this and supplying a patch.

Unfortunately, this solution moving the location of the file alters
the published ABI
(/Documents/ABI/testing/sysfs-bus-coresight-devices-etm4x), which is
generally not permitted

The file is associated with a register - TRCTRACIDR - so to fix this
we need a solution to ensure the offset is correctly set in the
attribute.

The first few versions of the Trace ID set that you reference did do
this correctly, but some code change after a review in a later version
introduced the error which we did not then notice.

Based on that earlier work have sent a fix patch that restores the
visibility of this register in the mgmt/ directory.

Thanks and regards

Mike

On Fri, 12 May 2023 at 03:41, Junhao He <hejunhao3@huawei.com> wrote:
>
> The trctraceid sysfs interface is current in etm4x mgmt group.
> Each attr in the mgmt group will call the function is_visible()
> to check whether the register is implemented. However the trctraceid
> does not bound to any register. So the trctraceid sysfs will
> always be invisible.
>
> Move it to etmv4 group to fix that.
>
> Fixes: df4871204e5d ("coresight: etm4x: Update ETM4 driver to use Trace ID API")
> Signed-off-by: Junhao He <hejunhao3@huawei.com>
> ---
>  .../coresight/coresight-etm4x-sysfs.c         | 42 +++++++++----------
>  1 file changed, 21 insertions(+), 21 deletions(-)
>
> diff --git a/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c b/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c
> index 5e62aa40ecd0..0ea71de0f56b 100644
> --- a/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c
> +++ b/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c
> @@ -2335,6 +2335,26 @@ static ssize_t ts_source_show(struct device *dev,
>  }
>  static DEVICE_ATTR_RO(ts_source);
>
> +/*
> + * Trace ID allocated dynamically on enable - but also allocate on read
> + * in case sysfs or perf read before enable to ensure consistent metadata
> + * information for trace decode
> + */
> +static ssize_t trctraceid_show(struct device *dev,
> +                              struct device_attribute *attr,
> +                              char *buf)
> +{
> +       int trace_id;
> +       struct etmv4_drvdata *drvdata = dev_get_drvdata(dev->parent);
> +
> +       trace_id = etm4_read_alloc_trace_id(drvdata);
> +       if (trace_id < 0)
> +               return trace_id;
> +
> +       return sysfs_emit(buf, "0x%x\n", trace_id);
> +}
> +static DEVICE_ATTR_RO(trctraceid);
> +
>  static struct attribute *coresight_etmv4_attrs[] = {
>         &dev_attr_nr_pe_cmp.attr,
>         &dev_attr_nr_addr_cmp.attr,
> @@ -2390,29 +2410,10 @@ static struct attribute *coresight_etmv4_attrs[] = {
>         &dev_attr_vmid_masks.attr,
>         &dev_attr_cpu.attr,
>         &dev_attr_ts_source.attr,
> +       &dev_attr_trctraceid.attr,
>         NULL,
>  };
>
> -/*
> - * Trace ID allocated dynamically on enable - but also allocate on read
> - * in case sysfs or perf read before enable to ensure consistent metadata
> - * information for trace decode
> - */
> -static ssize_t trctraceid_show(struct device *dev,
> -                              struct device_attribute *attr,
> -                              char *buf)
> -{
> -       int trace_id;
> -       struct etmv4_drvdata *drvdata = dev_get_drvdata(dev->parent);
> -
> -       trace_id = etm4_read_alloc_trace_id(drvdata);
> -       if (trace_id < 0)
> -               return trace_id;
> -
> -       return sysfs_emit(buf, "0x%x\n", trace_id);
> -}
> -static DEVICE_ATTR_RO(trctraceid);
> -
>  struct etmv4_reg {
>         struct coresight_device *csdev;
>         u32 offset;
> @@ -2549,7 +2550,6 @@ static struct attribute *coresight_etmv4_mgmt_attrs[] = {
>         coresight_etm4x_reg(trcpidr3, TRCPIDR3),
>         coresight_etm4x_reg(trcoslsr, TRCOSLSR),
>         coresight_etm4x_reg(trcconfig, TRCCONFIGR),
> -       &dev_attr_trctraceid.attr,
>         coresight_etm4x_reg(trcdevarch, TRCDEVARCH),
>         NULL,
>  };
> --
> 2.33.0
>
> _______________________________________________
> CoreSight mailing list -- coresight@lists.linaro.org
> To unsubscribe send an email to coresight-leave@lists.linaro.org



-- 
Mike Leach
Principal Engineer, ARM Ltd.
Manchester Design Centre. UK
