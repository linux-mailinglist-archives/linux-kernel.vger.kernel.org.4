Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F8DF6D8500
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 19:37:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231906AbjDERhA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 13:37:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231346AbjDERg6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 13:36:58 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 992295B81;
        Wed,  5 Apr 2023 10:36:57 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id h11so40699199lfu.8;
        Wed, 05 Apr 2023 10:36:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680716216;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=io+3jqowGGlAADxVVVRHguq+rruQrbxOod7tsbpQt3o=;
        b=geRNmWWoe1Vh4jNpLy+p+ZQ87NyvywzksSKDMvC0J19WfU9cRrGQJuofOhdVR7WXAY
         4BZk8H6k1OILfymJ0RgUheRJ31XYd/TJaNhg7ZIHMDulFSuV59YZ71xmqRacdOTyy81e
         OWylE9/Q//M3aR4JTPXck1iPpKrRPlpQxBWHsXXWfljNUJB5YjhbtkKTn10F6Zrxxtrs
         KQLejFMjyDwgF1RGHNds/vK0o8aQiUfSRIW39Cq8hh8uw4t18Ne1Ddh7xUstJAQgX5YG
         tqX+KKEqLsoBUAaXkhA8PXGWr3cdoBcxX4YIolYmmdNnlbhLB3VNUTiYnZSUbLp2n4ez
         amJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680716216;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=io+3jqowGGlAADxVVVRHguq+rruQrbxOod7tsbpQt3o=;
        b=1/BZuqGFx1SzHVMEz0YW2IIL8K8fF1doFapSR5uYXbeMjU7YydbjMdUkIaDwvYp/AD
         lDKX0or/QGqNRhzk6IP4j+DjxU2OTeImZsP95Ja2FV3GDQiu6azjBY9niQ84ydvMLCaf
         RXIMkVmm4N70dkWcMSIKhNn4VbrzVN18weQxG9EjSnLNj1gBqMdDvorkF97VQPaBwy5O
         L8z9ZahxyjcTrY2PVA2P6eaBwexZy5FwCKLMJWOOEdRPuShyKEzNVJCBJcmSKmjepBxS
         Plcmw96YLsJ6WZAX6ItrnsyIliRlFZASxjS/RGyDA2s3+o1aMKzRNKkqOUXXzQ5foBQR
         N12g==
X-Gm-Message-State: AAQBX9fJ/5tR4QWp1WyqqA6ieinvRZ0f6H1CF3BhI1lJGH76CmhS6iV1
        kaGoebb+zrgatQBJUgMHpgmJ3XnqvO5JMMvFknsE0zBfAvU=
X-Google-Smtp-Source: AKy350a2O9eO93p10bVJLARVQzbIgEn2r3CdtkEFAGSgP85LLIHkG28POYjsOY8rGPh+VA4Ccdw80naQnsJ2VBeo/ME=
X-Received: by 2002:a05:6512:12d4:b0:4e8:3ee1:db14 with SMTP id
 p20-20020a05651212d400b004e83ee1db14mr1783567lfg.6.1680716215745; Wed, 05 Apr
 2023 10:36:55 -0700 (PDT)
MIME-Version: 1.0
References: <20230405131647.6389-1-tbecker@redhat.com>
In-Reply-To: <20230405131647.6389-1-tbecker@redhat.com>
From:   Steve French <smfrench@gmail.com>
Date:   Wed, 5 Apr 2023 12:36:44 -0500
Message-ID: <CAH2r5mv93nJKNrAz=7DfYKEZrN=gUA7pXciD_Kyr8yVdFGR_Lg@mail.gmail.com>
Subject: Re: [PATCH v2] cifs: sanitize paths in cifs_update_super_prepath.
To:     Thiago Becker <tbecker@redhat.com>
Cc:     Steve French <sfrench@samba.org>, Paulo Alcantara <pc@cjr.nz>,
        Ronnie Sahlberg <lsahlber@redhat.com>,
        Shyam Prasad N <sprasad@microsoft.com>,
        Tom Talpey <tom@talpey.com>,
        Thiago Rafael Becker <trbecker@gmail.com>,
        Steve French <stfrench@microsoft.com>,
        linux-cifs@vger.kernel.org, samba-technical@lists.samba.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Added to cifs-2.6.git for-next and updated the tag which says:

"Buglink:" to "Link:"  (see this email thread for context
https://lore.kernel.org/all/3b036087d80b8c0e07a46a1dbaaf4ad0d018f8d5.167421=
7480.git.linux@leemhuis.info/)

On Wed, Apr 5, 2023 at 8:28=E2=80=AFAM Thiago Becker <tbecker@redhat.com> w=
rote:
>
> After a server reboot, clients are failing to move files with ENOENT.
> This is caused by DFS referrals containing multiple separators, which
> the server move call doesn't recognize.
>
> v1: Initial patch.
> v2: Move prototype to header.
>
> BugLink: https://bugzilla.redhat.com/show_bug.cgi?id=3D2182472
> Fixes: a31080899d5f ("cifs: sanitize multiple delimiters in prepath")
> Actually-Fixes: 24e0a1eff9e2 ("cifs: switch to new mount api")
> Signed-off-by: Thiago Rafael Becker <tbecker@redhat.com>
> ---
>  fs/cifs/fs_context.c | 13 +++++++------
>  fs/cifs/fs_context.h |  3 +++
>  fs/cifs/misc.c       |  2 +-
>  3 files changed, 11 insertions(+), 7 deletions(-)
>
> diff --git a/fs/cifs/fs_context.c b/fs/cifs/fs_context.c
> index 6d13f8207e96a..ace11a1a7c8ab 100644
> --- a/fs/cifs/fs_context.c
> +++ b/fs/cifs/fs_context.c
> @@ -441,13 +441,14 @@ int smb3_parse_opt(const char *options, const char =
*key, char **val)
>   * but there are some bugs that prevent rename from working if there are
>   * multiple delimiters.
>   *
> - * Returns a sanitized duplicate of @path. The caller is responsible for
> - * cleaning up the original.
> + * Returns a sanitized duplicate of @path. @gfp indicates the GFP_* flag=
s
> + * for kstrdup.
> + * The caller is responsible for freeing the original.
>   */
>  #define IS_DELIM(c) ((c) =3D=3D '/' || (c) =3D=3D '\\')
> -static char *sanitize_path(char *path)
> +char *cifs_sanitize_prepath(char *prepath, gfp_t gfp)
>  {
> -       char *cursor1 =3D path, *cursor2 =3D path;
> +       char *cursor1 =3D prepath, *cursor2 =3D prepath;
>
>         /* skip all prepended delimiters */
>         while (IS_DELIM(*cursor1))
> @@ -469,7 +470,7 @@ static char *sanitize_path(char *path)
>                 cursor2--;
>
>         *(cursor2) =3D '\0';
> -       return kstrdup(path, GFP_KERNEL);
> +       return kstrdup(prepath, gfp);
>  }
>
>  /*
> @@ -531,7 +532,7 @@ smb3_parse_devname(const char *devname, struct smb3_f=
s_context *ctx)
>         if (!*pos)
>                 return 0;
>
> -       ctx->prepath =3D sanitize_path(pos);
> +       ctx->prepath =3D cifs_sanitize_prepath(pos, GFP_KERNEL);
>         if (!ctx->prepath)
>                 return -ENOMEM;
>
> diff --git a/fs/cifs/fs_context.h b/fs/cifs/fs_context.h
> index 3de00e7127ec4..f4eaf85589022 100644
> --- a/fs/cifs/fs_context.h
> +++ b/fs/cifs/fs_context.h
> @@ -287,4 +287,7 @@ extern void smb3_update_mnt_flags(struct cifs_sb_info=
 *cifs_sb);
>   */
>  #define SMB3_MAX_DCLOSETIMEO (1 << 30)
>  #define SMB3_DEF_DCLOSETIMEO (1 * HZ) /* even 1 sec enough to help eg op=
en/write/close/open/read */
> +
> +extern char *cifs_sanitize_prepath(char *prepath, gfp_t gfp);
> +
>  #endif
> diff --git a/fs/cifs/misc.c b/fs/cifs/misc.c
> index b44fb51968bfb..7f085ed2d866b 100644
> --- a/fs/cifs/misc.c
> +++ b/fs/cifs/misc.c
> @@ -1195,7 +1195,7 @@ int cifs_update_super_prepath(struct cifs_sb_info *=
cifs_sb, char *prefix)
>         kfree(cifs_sb->prepath);
>
>         if (prefix && *prefix) {
> -               cifs_sb->prepath =3D kstrdup(prefix, GFP_ATOMIC);
> +               cifs_sb->prepath =3D cifs_sanitize_prepath(prefix, GFP_AT=
OMIC);
>                 if (!cifs_sb->prepath)
>                         return -ENOMEM;
>
> --
> 2.39.2
>


--=20
Thanks,

Steve
