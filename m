Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9B746C6544
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 11:38:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231232AbjCWKiV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 06:38:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229589AbjCWKhm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 06:37:42 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B60671E5F9
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 03:34:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 62817B82051
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 10:34:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0505AC4339C
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 10:34:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679567649;
        bh=fJu4buwju+aXou8+VwqF0BZQbX9HcKk4lN1aVLiCobw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=NP9BcpC4iG0ZV2MbmZH201WUnV5YSjsNTzxzICfbYcfldnPbkMcSeoWyUZJdclUxs
         Gdyi6fsjL1ZTy0CvRoDbdNswtoqm5CrhVMuRNxe4wIKs+40r102n6rAIfrIIDsVCK7
         fOb+aZd7Ip7FWY90GVQ8dR4RCneXuLQb0FLc1i4u2rP16O5334F23+oJ5Go8UlevtL
         L7CqIvlNFxDuwoDmdYaQstPnNPVRUzdDfJABFD+Eq8z+/N7QjcmwajdurFBQ6Mbq56
         zXDfmmD0NpdKHebsDQZodGxq2z1SwmMVO+kPMS8QlfApKiBGJ12iDUIJIdMPFrSyxe
         DuEUGQTWh5lYQ==
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-5419d4c340aso387105487b3.11
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 03:34:08 -0700 (PDT)
X-Gm-Message-State: AAQBX9c8O85Fmv8LifM/XTOmVdNaIIxBpO2zPTO9ISjOLzaSY0UbIT9L
        CQbnokenqeAftHpXQ5+mpq+h/uPL6PBcSr3hoI4=
X-Google-Smtp-Source: AKy350YPEjHVSAhmQPCXnKtsgwqbKyg8CBncmUaehuSDRZziR65QgWO4mv97VCOV/F7KkCRmjNdFTCgBA1Z28mbqmKU=
X-Received: by 2002:a81:4505:0:b0:544:5042:324a with SMTP id
 s5-20020a814505000000b005445042324amr1624643ywa.3.1679567647951; Thu, 23 Mar
 2023 03:34:07 -0700 (PDT)
MIME-Version: 1.0
References: <20230323083553.16864-1-cai.huoqing@linux.dev> <20230323102952.GD2130371@linux.intel.com>
In-Reply-To: <20230323102952.GD2130371@linux.intel.com>
From:   Oded Gabbay <ogabbay@kernel.org>
Date:   Thu, 23 Mar 2023 12:33:41 +0200
X-Gmail-Original-Message-ID: <CAFCwf13Xi+w6OiR=_6Lqu9LPBfpmr-0deLUMkqsXsjXD0iKqNg@mail.gmail.com>
Message-ID: <CAFCwf13Xi+w6OiR=_6Lqu9LPBfpmr-0deLUMkqsXsjXD0iKqNg@mail.gmail.com>
Subject: Re: [PATCH] accel/habanalabs: Remove redundant pci_clear_master
To:     Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>
Cc:     Cai Huoqing <cai.huoqing@linux.dev>,
        Tomer Tayar <ttayar@habana.ai>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 23, 2023 at 12:29=E2=80=AFPM Stanislaw Gruszka
<stanislaw.gruszka@linux.intel.com> wrote:
>
> On Thu, Mar 23, 2023 at 04:35:49PM +0800, Cai Huoqing wrote:
> > Remove pci_clear_master to simplify the code,
> > the bus-mastering is also cleared in do_pci_disable_device,
> > like this:
> > ./drivers/pci/pci.c:2197
> > static void do_pci_disable_device(struct pci_dev *dev)
> > {
> >       u16 pci_command;
> >
> >       pci_read_config_word(dev, PCI_COMMAND, &pci_command);
> >       if (pci_command & PCI_COMMAND_MASTER) {
> >               pci_command &=3D ~PCI_COMMAND_MASTER;
> >               pci_write_config_word(dev, PCI_COMMAND, pci_command);
> >       }
> >
> >       pcibios_disable_device(dev);
> > }.
> > And dev->is_busmaster is set to 0 in pci_disable_device.
> >
> > Signed-off-by: Cai Huoqing <cai.huoqing@linux.dev>
> LGTM
>
> Reviewed-by: Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>
>
Applied to -next
Thanks,
Oded
