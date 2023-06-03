Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC3A7721306
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Jun 2023 23:00:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229530AbjFCVA2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Jun 2023 17:00:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229881AbjFCVA0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Jun 2023 17:00:26 -0400
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA88B1B7;
        Sat,  3 Jun 2023 14:00:23 -0700 (PDT)
Received: by mail-qk1-x732.google.com with SMTP id af79cd13be357-75d5469c856so5531285a.2;
        Sat, 03 Jun 2023 14:00:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685826023; x=1688418023;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ChwqNHO4n4dQaIkmbrYTAbuxsb0lC0FfWkWbJO6tejQ=;
        b=VeUQ8P9h6V2oQUzyNVd2Pu3Epb210rRaSp6gpHPVimQvYzgUESWQnd6MJG1ZJZETjf
         6kpE/Jpz5XiqUdCDnYS2XhoAspvjh2Kn/fZZtCqsN2aviyCE1kEEMDk5BKi8prG8zXvz
         5SMK1zCH6bxrDS0MaCAHB1mgs8eAWs5r0qSEwCl3qaaFlGuxPppaKbbnk0Xi9S72R4KC
         2ICrayGS5nzIrGUAxrElGxB5HxdavqsiXPsjafaiJihKJkurQyH6yFwV1plvUnlsCiXZ
         trUexfi9WnZYQBczTb4MhBUyawbwWFMS6fNSEfRGXS5dJGnxFiQyvcsHqcV4lcJpiWnA
         1KEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685826023; x=1688418023;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ChwqNHO4n4dQaIkmbrYTAbuxsb0lC0FfWkWbJO6tejQ=;
        b=IdBUShs2ao69Y40Gt30XB+lXsLLfcKzf26w5FtHYwGV2PwU8yumwvVmfZ4WwkH/5zr
         TRn0Jl+34n7KTEGiiskFb0qbO/VORxnsqGt+wFjXX5/urC9FO48j7/eudc/gBDvElVJI
         jgUIIMQ2kkV1ouF+yk9/izPnSLatW4Xziyh7PUgSJlYkXZrh01SKE+1iDaSK6/FZFf/j
         EynBFxGFEIHJIqlvASFEbgzhqvStWSc6JFeQbAR1GW6wahVWOWH1r2q2CwQ5blkPANjA
         Os4NV7XPvKSSX71R5lLYBDMJqF79hJwi0OVcQ2yZ5gsoR/B2IeNtFAeY7cetvC6MVuwb
         p3bA==
X-Gm-Message-State: AC+VfDzSLf0W/7ryvfoaIISl6rmhVe7uhyaF8xPu2As48ppPqOCQNqvd
        7mfRqivsaivh8E8cL6Zst3YJHgXcA3RpTop+c5oVUF7XTIg=
X-Google-Smtp-Source: ACHHUZ6O6ocQPxrRPXRp56qxVt9JI6j/OmIasCsxVz7ZcWpqDycSCaZskg8m9gb0afNTySqEgIKd2BzUrcYw3LgVmmc=
X-Received: by 2002:a05:620a:4903:b0:75b:23a1:3651 with SMTP id
 ed3-20020a05620a490300b0075b23a13651mr18777415qkb.18.1685826022846; Sat, 03
 Jun 2023 14:00:22 -0700 (PDT)
MIME-Version: 1.0
References: <20230602072755.7314-1-jiasheng@iscas.ac.cn> <202306040153.RPAlkz3U-lkp@intel.com>
In-Reply-To: <202306040153.RPAlkz3U-lkp@intel.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sat, 3 Jun 2023 23:59:46 +0300
Message-ID: <CAHp75Ve2sQ1i9tOAzOxuBmiA0G5djY6yXcQ_-P9ux6vnOr+DvQ@mail.gmail.com>
Subject: Re: [PATCH v2] gpio: sifive: Add missing check for platform_get_irq
To:     kernel test robot <lkp@intel.com>
Cc:     Jiasheng Jiang <jiasheng@iscas.ac.cn>,
        oe-kbuild-all@lists.linux.dev, linus.walleij@linaro.org,
        brgl@bgdev.pl, palmer@dabbelt.com, paul.walmsley@sifive.com,
        linux-gpio@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 3, 2023 at 8:48=E2=80=AFPM kernel test robot <lkp@intel.com> wr=
ote:
>
> Hi Jiasheng,
>
> kernel test robot noticed the following build warnings:
>
> [auto build test WARNING on brgl/gpio/for-next]
> [also build test WARNING on linus/master v6.4-rc4 next-20230602]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
>
> url:    https://github.com/intel-lab-lkp/linux/commits/Jiasheng-Jiang/gpi=
o-sifive-Add-missing-check-for-platform_get_irq/20230602-152856
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/brgl/linux.git gp=
io/for-next
> patch link:    https://lore.kernel.org/r/20230602072755.7314-1-jiasheng%4=
0iscas.ac.cn
> patch subject: [PATCH v2] gpio: sifive: Add missing check for platform_ge=
t_irq
> config: openrisc-randconfig-m041-20230531 (https://download.01.org/0day-c=
i/archive/20230604/202306040153.RPAlkz3U-lkp@intel.com/config)
> compiler: or1k-linux-gcc (GCC) 12.3.0
>
> If you fix the issue, kindly add following tag where applicable
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202306040153.RPAlkz3U-lkp=
@intel.com/
>
> smatch warnings:
> drivers/gpio/gpio-sifive.c:226 sifive_gpio_probe() warn: unsigned 'chip->=
irq_number[i]' is never less than zero.

Nice!

...

>    224          for (i =3D 0; i < ngpio; i++) {
>    225                  chip->irq_number[i] =3D platform_get_irq(pdev, i)=
;
>  > 226                  if (chip->irq_number[i] < 0)
>    227                          return chip->irq_number[i];

So, this should be

  ret =3D ...
  if (ret < 0)
    return ret;
  irq_number =3D ret;

>    228          }


--=20
With Best Regards,
Andy Shevchenko
