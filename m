Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B125C64B72B
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 15:19:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235832AbiLMOTv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 09:19:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235638AbiLMOTj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 09:19:39 -0500
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33F4E1DDF4;
        Tue, 13 Dec 2022 06:19:39 -0800 (PST)
Received: by mail-pj1-f42.google.com with SMTP id q17-20020a17090aa01100b002194cba32e9so3708335pjp.1;
        Tue, 13 Dec 2022 06:19:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6Ok6sreFEVb5J/h0KcNwa66v2DuHzP6P5urFq5ZB8SU=;
        b=ml8X2tPC24Vf0La73PS81HVG6yyKO5bTr2VBCCjOjGUMyIRjJEwpzptn38bgy8KHyJ
         C8CnhDkUzewKPBnEmUFq/rXdyVO5tm7pgjr6y89CGgKf2qJaaatssvIZHVLp6iCKnlBe
         FT+y/8aZPXJ1GL6xVmnvN1VAXcPJ+74xeflRGctpnBTeGotNS8etPC+53JA33p5hneQS
         VahqREzZbd9m2YP1kPyV8V7to48no7H0FzbMpMtFXH43lqdmSzBOQDrnfsVSjl6osO0k
         SX8JVcarcZ3L4lkaLxy21S4NvOe6XzPdw3PW9YeBxWcmjTlqcg0LE/tWTtwGUQU12tdw
         s1ew==
X-Gm-Message-State: ANoB5plq+qf5qpcWYJjiA6ZGLlkWfAqrp7fQcD+KxwsmeXttGXiviqSr
        +5CB728NVkpHieda9iBMwXkGD1qBmMjIgnhoG10=
X-Google-Smtp-Source: AA0mqf59mt/zVejTJoqt4IKykarqkHbmUROidA8fytmYXcn8QQIE28QBNuEu4908sjHhSkdz6xES69OMdveEQn2KgQo=
X-Received: by 2002:a17:902:aa04:b0:17f:6fee:3334 with SMTP id
 be4-20020a170902aa0400b0017f6fee3334mr80365158plb.10.1670941178552; Tue, 13
 Dec 2022 06:19:38 -0800 (PST)
MIME-Version: 1.0
References: <20221212152035.31806-1-johan@kernel.org>
In-Reply-To: <20221212152035.31806-1-johan@kernel.org>
From:   Vincent MAILHOL <mailhol.vincent@wanadoo.fr>
Date:   Tue, 13 Dec 2022 23:19:26 +0900
Message-ID: <CAMZ6Rq+EkE_wRh3-kv2ZRGyPHoonfR-cLApZPUb=3f2CRBeKFQ@mail.gmail.com>
Subject: Re: [PATCH v2] USB: fix misleading usb_set_intfdata() kernel doc
To:     Johan Hovold <johan@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Oliver Neukum <oneukum@suse.com>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue. 13 Dec. 2022 at 00:20, Johan Hovold <johan@kernel.org> wrote:
> The struct device driver-data pointer is used for any data that a driver
> may need in various callbacks while bound to the device. For
> convenience, subsystems typically provide wrappers such as
> usb_set_intfdata() of the generic accessor functions for use in bus
> callbacks.
>
> There is generally no longer any need for a driver to clear the pointer,
> but since commit 0998d0631001 ("device-core: Ensure drvdata = NULL when
> no driver is bound") the driver-data pointer is set to NULL by driver
> core post unbind anyway.
>
> For historical reasons, USB core also clears this pointer when an
> explicitly claimed interface is released.
>
> Due to a misunderstanding, a misleading kernel doc comment for
> usb_set_intfdata() was recently added which claimed that the driver data
> pointer must not be cleared during disconnect before "all actions [are]
> completed", which is both imprecise and incorrect.
>
> Specifically, drivers like cdc-acm which claim additional interfaces use
> the driver-data pointer as a flag which is cleared when the first
> interface is unbound. As long as a driver does not do something odd like
> dereference the pointer in, for example, completion callbacks, this can
> be done at any time during disconnect. And in any case this is no
> different than for any other resource, like the driver data itself,
> which may be freed by the disconnect callback.
>
> Note that the comment actually also claimed that the interface itself
> was somehow being set to NULL by driver core.
>
> Fix the kernel doc by removing incorrect, overly specific and misleading
> details and adding a comment about why some drivers do clear the
> driver-data pointer.
>
> Fixes: 27ef17849779 ("usb: add usb_set_intfdata() documentation")
> Signed-off-by: Johan Hovold <johan@kernel.org>

Thank you for fixing my mess :)

Acked-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>


Yours sincerely,
Vincent Mailhol
